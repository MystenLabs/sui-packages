module 0x5909888b4a96e7ff866abfb14b71c920c56589ec3147c7e2c27a4a952668df4f::waloogle {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct WaloogleIndex has key {
        id: 0x2::object::UID,
        index_blob_id: vector<u8>,
        last_updated_epoch: u64,
        site_count: u64,
        metadata: 0x2::vec_map::VecMap<vector<u8>, vector<u8>>,
    }

    struct Boost has key {
        id: 0x2::object::UID,
        site_object_id: 0x2::object::ID,
        owner: address,
        expires_epoch: u64,
        paid_mist: u64,
        epochs: u64,
    }

    struct BoostCreated has copy, drop {
        boost_id: 0x2::object::ID,
        site_object_id: 0x2::object::ID,
        owner: address,
        expires_epoch: u64,
        paid_mist: u64,
    }

    struct BoostExpired has copy, drop {
        boost_id: 0x2::object::ID,
        site_object_id: 0x2::object::ID,
        owner: address,
    }

    struct IndexUpdated has copy, drop {
        new_blob_id: vector<u8>,
        updated_at_epoch: u64,
        site_count: u64,
    }

    public entry fun boost_site(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        let v0 = arg1 * 1000000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg3), @0xce4be8bcc98ee6a8ffdf3da5b7ae9d6ab14f77f112a9df81e966903c19b4295f);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v1 = 0x2::tx_context::epoch(arg3) + arg1;
        let v2 = Boost{
            id             : 0x2::object::new(arg3),
            site_object_id : arg0,
            owner          : 0x2::tx_context::sender(arg3),
            expires_epoch  : v1,
            paid_mist      : v0,
            epochs         : arg1,
        };
        let v3 = BoostCreated{
            boost_id       : 0x2::object::id<Boost>(&v2),
            site_object_id : arg0,
            owner          : 0x2::tx_context::sender(arg3),
            expires_epoch  : v1,
            paid_mist      : v0,
        };
        0x2::event::emit<BoostCreated>(v3);
        0x2::transfer::transfer<Boost>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun boosted_site(arg0: &Boost) : 0x2::object::ID {
        arg0.site_object_id
    }

    public fun epochs_remaining(arg0: &Boost, arg1: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::epoch(arg1);
        if (v0 >= arg0.expires_epoch) {
            0
        } else {
            arg0.expires_epoch - v0
        }
    }

    public fun index_blob_id(arg0: &WaloogleIndex) : vector<u8> {
        arg0.index_blob_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = WaloogleIndex{
            id                 : 0x2::object::new(arg0),
            index_blob_id      : b"",
            last_updated_epoch : 0,
            site_count         : 0,
            metadata           : 0x2::vec_map::empty<vector<u8>, vector<u8>>(),
        };
        0x2::transfer::share_object<WaloogleIndex>(v1);
    }

    public fun is_active(arg0: &Boost, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch(arg1) < arg0.expires_epoch
    }

    public fun min_mist_per_epoch() : u64 {
        1000000000
    }

    public entry fun set_metadata(arg0: &AdminCap, arg1: &mut WaloogleIndex, arg2: vector<u8>, arg3: vector<u8>) {
        if (0x2::vec_map::contains<vector<u8>, vector<u8>>(&arg1.metadata, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<vector<u8>, vector<u8>>(&mut arg1.metadata, &arg2);
        };
        0x2::vec_map::insert<vector<u8>, vector<u8>>(&mut arg1.metadata, arg2, arg3);
    }

    public fun treasury() : address {
        @0xce4be8bcc98ee6a8ffdf3da5b7ae9d6ab14f77f112a9df81e966903c19b4295f
    }

    public entry fun update_index(arg0: &AdminCap, arg1: &mut WaloogleIndex, arg2: vector<u8>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg2), 2);
        arg1.index_blob_id = arg2;
        arg1.last_updated_epoch = 0x2::tx_context::epoch(arg4);
        arg1.site_count = arg3;
        let v0 = IndexUpdated{
            new_blob_id      : arg1.index_blob_id,
            updated_at_epoch : arg1.last_updated_epoch,
            site_count       : arg3,
        };
        0x2::event::emit<IndexUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}


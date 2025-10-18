module 0xc82b0c59355930a30a7b9898e705d3c075ebfc9c3271ca8d9b17ca21c43fd831::walrus_staker_nfts {
    struct WALRUS_STAKER_NFTS has drop {
        dummy_field: bool,
    }

    struct Og has drop, store {
        dummy_field: bool,
    }

    struct WalFan has drop, store {
        dummy_field: bool,
    }

    struct WalStaker has drop, store {
        dummy_field: bool,
    }

    struct WalrusStaker<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFTMInted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
    }

    fun create<T0: drop + store>(arg0: &mut 0x2::tx_context::TxContext) : WalrusStaker<T0> {
        WalrusStaker<T0>{id: 0x2::object::new(arg0)}
    }

    public fun create_admin(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    fun init(arg0: WALRUS_STAKER_NFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<WALRUS_STAKER_NFTS>(arg0, arg1);
        let v1 = 0x2::display::new<WalrusStaker<Og>>(&v0, arg1);
        0x2::display::add<WalrusStaker<Og>>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Og Rank"));
        0x2::display::add<WalrusStaker<Og>>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"You staked for More than 90 days"));
        0x2::display::add<WalrusStaker<Og>>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/GXPFFU1jln8Ow8wb4chigVQFKtvg3TwWxXAjkMa_nUE"));
        0x2::display::update_version<WalrusStaker<Og>>(&mut v1);
        let v2 = 0x2::display::new<WalrusStaker<WalFan>>(&v0, arg1);
        0x2::display::add<WalrusStaker<WalFan>>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Wal Fan Rank"));
        0x2::display::add<WalrusStaker<WalFan>>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"You staked for More than 60 days"));
        0x2::display::add<WalrusStaker<WalFan>>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/jtUOua1s0xoudc4aANEgeM8uMY92RfHbPjFNbU5Or8M"));
        0x2::display::update_version<WalrusStaker<WalFan>>(&mut v2);
        let v3 = 0x2::display::new<WalrusStaker<WalStaker>>(&v0, arg1);
        0x2::display::add<WalrusStaker<WalStaker>>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Wal Staker Rank"));
        0x2::display::add<WalrusStaker<WalStaker>>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"You staked on walrus"));
        0x2::display::add<WalrusStaker<WalStaker>>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/JFFpnLwxg7ghsMKhL46e3owGpTpN7ne3JPrDqA1xYRk"));
        0x2::display::update_version<WalrusStaker<WalStaker>>(&mut v3);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::display::Display<WalrusStaker<Og>>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WalrusStaker<WalFan>>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WalrusStaker<WalStaker>>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to_recepient<T0: drop + store>(arg0: address, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = create<T0>(arg2);
        let v1 = NFTMInted{
            object_id : 0x2::object::id<WalrusStaker<T0>>(&v0),
            creator   : arg0,
        };
        0x2::event::emit<NFTMInted>(v1);
        0x2::transfer::transfer<WalrusStaker<T0>>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}


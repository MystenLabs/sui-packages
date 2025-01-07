module 0xb98e5c52f7923c6d24dd5736002500cbc2fe13ecda219001733d0cf537b3ae3::base_nft {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct NFTMinted has copy, drop {
        token_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct NFTBatchMinted has copy, drop {
        token_ids: vector<0x2::object::ID>,
        creator: address,
        name: 0x1::string::String,
        no_of_tokens: u64,
    }

    struct NFTBurned<phantom T0> has copy, drop {
        token_id: 0x2::object::ID,
    }

    struct TransferredObject<phantom T0> has copy, drop {
        token_id: 0x2::object::ID,
        recipient: address,
    }

    struct NFTMetadataUpdated has copy, drop {
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct AttributesUpdated<T0, T1> has copy, drop {
        key: T0,
        value: T1,
    }

    public fun emit_batch_mint_nft(arg0: vector<0x2::object::ID>, arg1: u64, arg2: address, arg3: 0x1::string::String) {
        let v0 = NFTBatchMinted{
            token_ids    : arg0,
            creator      : arg2,
            name         : arg3,
            no_of_tokens : arg1,
        };
        0x2::event::emit<NFTBatchMinted>(v0);
    }

    public fun emit_burn_nft<T0>(arg0: 0x2::object::ID) {
        let v0 = NFTBurned<T0>{token_id: arg0};
        0x2::event::emit<NFTBurned<T0>>(v0);
    }

    public fun emit_metadat_update(arg0: 0x1::string::String, arg1: 0x1::string::String) {
        let v0 = NFTMetadataUpdated{
            name        : arg0,
            description : arg1,
        };
        0x2::event::emit<NFTMetadataUpdated>(v0);
    }

    public fun emit_mint_nft(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String) {
        let v0 = NFTMinted{
            token_id : arg0,
            creator  : arg1,
            name     : arg2,
        };
        0x2::event::emit<NFTMinted>(v0);
    }

    fun emit_transfer<T0>(arg0: 0x2::object::ID, arg1: address) {
        let v0 = TransferredObject<T0>{
            token_id  : arg0,
            recipient : arg1,
        };
        0x2::event::emit<TransferredObject<T0>>(v0);
    }

    public fun emit_transfer_object<T0>(arg0: 0x2::object::ID, arg1: address) {
        emit_transfer<T0>(arg0, arg1);
    }

    public fun emit_update_attributes<T0: copy + drop, T1: copy + drop>(arg0: T0, arg1: T1) {
        let v0 = AttributesUpdated<T0, T1>{
            key   : arg0,
            value : arg1,
        };
        0x2::event::emit<AttributesUpdated<T0, T1>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        emit_transfer<AdminCap>(0x2::object::id<AdminCap>(&arg0), arg1);
    }

    public entry fun transfer_display_object<T0: store + key>(arg0: 0x2::display::Display<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(arg0, arg1);
        emit_transfer<0x2::display::Display<T0>>(0x2::object::id<0x2::display::Display<T0>>(&arg0), arg1);
    }

    public entry fun transfer_publisher_object(arg0: 0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(arg0, arg1);
        emit_transfer<0x2::package::Publisher>(0x2::object::id<0x2::package::Publisher>(&arg0), arg1);
    }

    public entry fun transfer_upgrade_object(arg0: 0x2::package::UpgradeCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg0, arg1);
        emit_transfer<0x2::package::UpgradeCap>(0x2::object::id<0x2::package::UpgradeCap>(&arg0), arg1);
    }

    public fun update_attribute<T0: copy + drop, T1: copy + drop>(arg0: &mut 0x2::vec_map::VecMap<T0, T1>, arg1: T0, arg2: T1) {
        let (_, _) = 0x2::vec_map::remove<T0, T1>(arg0, &arg1);
        0x2::vec_map::insert<T0, T1>(arg0, arg1, arg2);
        let v2 = AttributesUpdated<T0, T1>{
            key   : arg1,
            value : arg2,
        };
        0x2::event::emit<AttributesUpdated<T0, T1>>(v2);
    }

    // decompiled from Move bytecode v6
}


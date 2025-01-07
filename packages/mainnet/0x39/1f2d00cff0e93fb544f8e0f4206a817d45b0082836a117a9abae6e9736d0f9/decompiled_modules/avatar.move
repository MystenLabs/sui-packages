module 0x391f2d00cff0e93fb544f8e0f4206a817d45b0082836a117a9abae6e9736d0f9::avatar {
    struct AVATAR has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        n_mints: u64,
    }

    struct Avatar has key {
        id: 0x2::object::UID,
        owner: 0x1::string::String,
        model_id: 0x1::string::String,
        image_id: 0x1::string::String,
    }

    public fun admin_create_mint_cap(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : MintCap {
        MintCap{
            id      : 0x2::object::new(arg2),
            n_mints : arg1,
        }
    }

    public fun admin_transfer_mint_cap(arg0: &AdminCap, arg1: MintCap, arg2: address) {
        0x2::transfer::transfer<MintCap>(arg1, arg2);
    }

    public fun admin_update_mint_cap(arg0: &AdminCap, arg1: &mut MintCap, arg2: u64) {
        arg1.n_mints = arg2;
    }

    public fun burn_mintcap(arg0: MintCap) {
        let MintCap {
            id      : v0,
            n_mints : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: AVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<AVATAR>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_avatar(arg0: &mut MintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Avatar {
        let v0 = &mut arg0.n_mints;
        assert!(*v0 != 0, 0);
        *v0 = *v0 - 1;
        Avatar{
            id       : 0x2::object::new(arg4),
            owner    : arg1,
            model_id : arg2,
            image_id : arg3,
        }
    }

    public fun minter_transfer_avatar(arg0: &MintCap, arg1: Avatar, arg2: address) {
        0x2::transfer::transfer<Avatar>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}


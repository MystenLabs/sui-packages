module 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::ika_dwallet_2pc_mpc_init {
    struct IKA_DWALLET_2PC_MPC_INIT has drop {
        dummy_field: bool,
    }

    struct InitCap has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    fun init(arg0: IKA_DWALLET_2PC_MPC_INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = InitCap{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<IKA_DWALLET_2PC_MPC_INIT>(arg0, arg1),
        };
        0x2::transfer::transfer<InitCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize(arg0: InitCap, arg1: &mut 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::advance_epoch_approver::AdvanceEpochApprover, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_current_status_info::SystemCurrentStatusInfo, arg3: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::pricing::PricingInfo, arg4: 0x2::vec_map::VecMap<u32, 0x2::vec_map::VecMap<u32, vector<u32>>>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        let InitCap {
            id        : v0,
            publisher : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = 0x1::type_name::with_defining_ids<InitCap>();
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v2));
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::create(0x2::object::id_from_address(0x2::address::from_ascii_bytes(&v3)), arg1, arg2, arg3, arg4, arg11);
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::ika_dwallet_2pc_mpc_display::create(v1, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    // decompiled from Move bytecode v6
}


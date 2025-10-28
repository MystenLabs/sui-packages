module 0xef97a597e778673cb982cff3922d5b826a8ae972f1653593b50d14df0f386143::myoft_deploy {
    struct MYOFT_DEPLOY has drop {
        dummy_field: bool,
    }

    struct MyOFTInitTicket has key {
        id: 0x2::object::UID,
        oft_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        oapp_object: address,
        admin_cap: 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap,
    }

    fun destroy_ticket(arg0: MyOFTInitTicket, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp) : (0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap) {
        let MyOFTInitTicket {
            id          : v0,
            oft_cap     : v1,
            oapp_object : v2,
            admin_cap   : v3,
        } = arg0;
        assert!(v2 == 0x2::object::id_address<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp>(arg1), 1);
        0x2::object::delete(v0);
        (v1, v3)
    }

    fun init(arg0: MYOFT_DEPLOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::new<MYOFT_DEPLOY>(&arg0, arg1);
        let v3 = MyOFTInitTicket{
            id          : 0x2::object::new(arg1),
            oft_cap     : v0,
            oapp_object : v2,
            admin_cap   : v1,
        };
        0x2::transfer::transfer<MyOFTInitTicket>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun init_myoft<T0>(arg0: MyOFTInitTicket, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap, 0xdcedfbd5aa43274ada0a8416766cc18718b5ee8be151ad5ed43ff941343395d9::migration::MigrationCap) {
        let (v0, v1) = destroy_ticket(arg0, arg1);
        (v1, 0xef97a597e778673cb982cff3922d5b826a8ae972f1653593b50d14df0f386143::oft::init_oft<T0>(arg1, v0, arg2, arg3, 6, arg4))
    }

    // decompiled from Move bytecode v6
}


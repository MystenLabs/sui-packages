module 0xb0c64367bf48666b3b726d3601fe4ec39fc4af30f48399bae30daac6cfb7fb66::voloro {
    struct Voloro has key {
        id: 0x2::object::UID,
    }

    public fun create_ds_token(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: &mut 0x2::coin_registry::CoinRegistry, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::MetadataCap<Voloro>, 0x2::coin::TreasuryCap<Voloro>) {
        let (v0, v1) = 0x2::coin_registry::new_currency<Voloro>(arg5, arg4, arg1, arg0, arg3, arg2, arg6);
        (0x2::coin_registry::finalize<Voloro>(v0, arg6), v1)
    }

    // decompiled from Move bytecode v6
}


module 0xc89a614e5f7e45983dfdff376b896542ee90bbbe4d1618e7b0009ba46fbc3520::suilo {
    struct SUILO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILO>(arg0, 6, b"SUILO", b"SuiloSui", b"teh must wetarded cet on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z_AEL_y_U_400x400_3734182cf3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILO>>(v1);
    }

    // decompiled from Move bytecode v6
}


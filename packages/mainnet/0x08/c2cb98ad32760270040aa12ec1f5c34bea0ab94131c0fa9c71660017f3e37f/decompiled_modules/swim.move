module 0x8c2cb98ad32760270040aa12ec1f5c34bea0ab94131c0fa9c71660017f3e37f::swim {
    struct SWIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SWIM>(arg0, 6, b"SWIM", b"dog in the swimming pool", b"dog in the swimming pool, to find $sui gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/P_Kp_Eb_J_dfb3fa3480.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SWIM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


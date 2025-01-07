module 0xe4afc908156308a714f4e530f473311cd24081ebf8331303e69efbe7e804985d::angrypig {
    struct ANGRYPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGRYPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGRYPIG>(arg0, 6, b"ANGRYPIG", b"ANGRY PIG", b"WELCPME TO ANGRY PIG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730999515495.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANGRYPIG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGRYPIG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x8298035796153260d1d0c5ddb1208fb279792693f2a8822c12be901a81cc5672::scode {
    struct SCODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCODE>(arg0, 6, b"SCODE", b"SUICODE", b"Suicode: A simple, unique code solution for Aptos, designed to streamline and simplify coding tasks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731042479153.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCODE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCODE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


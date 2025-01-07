module 0x50fba7e9f14a73e54b71ae7cbad0dc7eef28a35ad9fe20b461459f7b90b04d15::risk {
    struct RISK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RISK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RISK>(arg0, 6, b"RISK", b"RISUI", b"The biggest risk is not taking the risk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/06_CWGV_Tdyt_7b2369fc09.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RISK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RISK>>(v1);
    }

    // decompiled from Move bytecode v6
}


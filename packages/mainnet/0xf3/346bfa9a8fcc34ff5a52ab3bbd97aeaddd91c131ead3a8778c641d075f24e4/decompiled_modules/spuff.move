module 0xf3346bfa9a8fcc34ff5a52ab3bbd97aeaddd91c131ead3a8778c641d075f24e4::spuff {
    struct SPUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUFF>(arg0, 6, b"sPUFF", b"Smiling Pufferfish", x"4c61756e6368696e67207468697320616761696e206265636175736520636f6d6d756e69747920727567676564207468656d73656c7665732064756520746f206e6f205447206170706172656e746c792e2020596f7520677579732063746f2074686973206f722049206c6f737420666169746820696e20245355490a0a49276c6c2070617920646578207265676172646c657373206265636175736520492077616e7420746f207365652074686973206d656d652074687269766521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053994_d63bd19554.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}


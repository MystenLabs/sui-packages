module 0x449c4e317f2bec70e7a56d122a559c06e5b52c5da1daaae7d92523857e1ab48a::ntl {
    struct NTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTL>(arg0, 9, b"NTL", b"Dragon ", b"when whales fly that is my hope", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c71146e-a8a0-45f5-979d-bb82e89cb571.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTL>>(v1);
    }

    // decompiled from Move bytecode v6
}


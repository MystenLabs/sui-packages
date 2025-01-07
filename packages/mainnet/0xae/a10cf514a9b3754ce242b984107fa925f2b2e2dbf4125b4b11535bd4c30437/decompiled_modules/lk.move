module 0xaea10cf514a9b3754ce242b984107fa925f2b2e2dbf4125b4b11535bd4c30437::lk {
    struct LK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LK>(arg0, 9, b"LK", b"Linh Ka", x"4c696e682043c3a1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/263906fb-23b8-4d3f-8024-5c3c9a456088.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LK>>(v1);
    }

    // decompiled from Move bytecode v6
}


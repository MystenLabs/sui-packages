module 0xd003a86f9f2c9dbd22049976fd5dd28a9702c6e00203313d679ba829888a5a6d::cgk {
    struct CGK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CGK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CGK>(arg0, 9, b"CGK", b"CINGOGOK", b"Cingogok Meme Pirates", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18958780-9de4-4bc6-82d7-0ba52f6fdbdc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CGK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CGK>>(v1);
    }

    // decompiled from Move bytecode v6
}


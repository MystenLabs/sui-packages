module 0x5f687ef0e452e0a8b745888df5e820a243710498dbe330948555129caf22b537::hanbao {
    struct HANBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANBAO>(arg0, 6, b"Hanbao", b"Hanbao on Sui", b"Hanbao the finless porpoise ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1980_252541bc1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}


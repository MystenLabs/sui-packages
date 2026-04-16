module 0xb1b9a6dbdf28105fd1f0742e6402fd6b444fb3b340007821b053304f533aa4db::ai_penguin {
    struct AI_PENGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI_PENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI_PENGUIN>(arg0, 9, b"AI Penguin", b"AI Penguin", b"AI Penguin it's live", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776270904811-3a46dd9ad0f3a3d0c01246a02deb8a2f.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AI_PENGUIN>>(0x2::coin::mint<AI_PENGUIN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AI_PENGUIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI_PENGUIN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}


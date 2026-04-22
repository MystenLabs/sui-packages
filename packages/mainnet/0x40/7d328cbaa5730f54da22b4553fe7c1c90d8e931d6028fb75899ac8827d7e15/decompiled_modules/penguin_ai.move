module 0x407d328cbaa5730f54da22b4553fe7c1c90d8e931d6028fb75899ac8827d7e15::penguin_ai {
    struct PENGUIN_AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUIN_AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUIN_AI>(arg0, 9, b"Penguin AI", b"Penguin AI Coin", b"Penguin AI on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776884970181-3a46dd9ad0f3a3d0c01246a02deb8a2f.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PENGUIN_AI>>(0x2::coin::mint<PENGUIN_AI>(&mut v2, 50000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENGUIN_AI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUIN_AI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}


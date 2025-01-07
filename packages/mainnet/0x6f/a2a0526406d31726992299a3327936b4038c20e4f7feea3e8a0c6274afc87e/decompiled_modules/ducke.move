module 0x6fa2a0526406d31726992299a3327936b4038c20e4f7feea3e8a0c6274afc87e::ducke {
    struct DUCKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKE>(arg0, 9, b"DUCKE", b"Ducke", b"No copy-paste here. Just original, feathered fun. Quack your way to the hottest meme on Sui with $DUCKE!  https://t.me/DuckeSUI  https://x.com/DuckeSUI  https://duckesui.site", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/duckesui/ducke/refs/heads/main/image_2024-10-16_01-23-38.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUCKE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKE>>(v1);
    }

    // decompiled from Move bytecode v6
}


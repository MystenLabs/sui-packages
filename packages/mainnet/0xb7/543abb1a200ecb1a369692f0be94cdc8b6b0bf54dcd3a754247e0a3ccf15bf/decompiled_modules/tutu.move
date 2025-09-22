module 0xb7543abb1a200ecb1a369692f0be94cdc8b6b0bf54dcd3a754247e0a3ccf15bf::tutu {
    struct TUTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUTU>(arg0, 0, b"tutu", b"tutu", b"tutu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://meme.rolipoli.xyz/meme-icons/1758545787009_ChatGPT Image Sep 21, 2025 at 09_55_16 PM.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TUTU>>(0x2::coin::mint<TUTU>(&mut v2, 100, arg1), @0x6dc40a6b35310e5dd5cb7767f8d8477b9c1fc219f0cc511f45928eddaae341dd);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TUTU>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUTU>>(v1);
    }

    // decompiled from Move bytecode v6
}


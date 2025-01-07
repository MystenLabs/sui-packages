module 0xb2f0a3c2aa2a1315df6dad43c80a162f936e3de473ce98a10a29a7c98c2db887::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 9, b"Scat", b"Sprite Cat On Sui", b"Dive into the pixelated world of SpriteCat, the ultimate crypto mascot designed to bring fun and fortune to your wallet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ab1fc669500e08151cb5ec04175ba00fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


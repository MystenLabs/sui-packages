module 0x1c44a73bece1abcd80288aa01ea2d514b4bc5133a68fcd39f366a4db84e2c6bb::angler {
    struct ANGLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGLER>(arg0, 6, b"ANGLER", b"AnglerFish", b"$ANGLER is a deep-sea memecoin inspired by the mysterious and captivating world of the anglerfish. Just like the black seadevil lures its prey with a glowing light in the darkest depths, $ANGLER will light the way for those daring enough to explore the unknown waters of the crypto world. With a community-driven focus, this token aims to hook the attention of enthusiasts who thrive on innovation, risk, and the thrill of discovery. Whether youre a seasoned sailor of the crypto seas or a curious newcomer, $ANGLER is ready to reel you in for a journey of growth and adventure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ceea6d86e660b3a8206939cab475df79_8345915af0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGLER>>(v1);
    }

    // decompiled from Move bytecode v6
}


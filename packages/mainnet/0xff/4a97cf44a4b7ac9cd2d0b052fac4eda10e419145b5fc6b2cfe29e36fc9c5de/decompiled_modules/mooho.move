module 0xff4a97cf44a4b7ac9cd2d0b052fac4eda10e419145b5fc6b2cfe29e36fc9c5de::mooho {
    struct MOOHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOHO>(arg0, 6, b"MOOHO", b"Sui Mooho", b"MOOHO - Moo deng's Cousin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024776_546a6c3d4d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOHO>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x9ba184cda17811f5843baea1f606f90f1509bf96ab7b6a5b50f43bd6a814ab15::moodfood {
    struct MOODFOOD has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOODFOOD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOODFOOD>>(0x2::coin::mint<MOODFOOD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOODFOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODFOOD>(arg0, 6, b"MDFD", b"MoodFood", b"Amazing creations from a world class chef; the passion project of one man's pursuit towards the prosperity of all people, through foraging the finest foods.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeibc64tpp3c7rdbciokhzelnnraf4rd6gmrewcjjcay25xr5i6zjoi.ipfs.dweb.link/IMG_5912.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOODFOOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODFOOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xb08d9d8256b4c15aa59a8fcf8c67d9ae3dbf5c95c31e42963723efed73f781ed::stsui {
    struct STSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STSUI>(arg0, 9, b"STSUI", b"STSUI", b"STSUI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/nfttokenasa/image/upload/v1740644506/qavcs7etnm0ko0q4z3r6.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


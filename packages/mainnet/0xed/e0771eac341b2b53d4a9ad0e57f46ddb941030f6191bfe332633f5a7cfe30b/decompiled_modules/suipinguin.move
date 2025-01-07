module 0xede0771eac341b2b53d4a9ad0e57f46ddb941030f6191bfe332633f5a7cfe30b::suipinguin {
    struct SUIPINGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPINGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPINGUIN>(arg0, 6, b"SUIPINGUIN", b"SUIPI", b"$SUIPI embark on an icy adventure like no other tands as a distinctive meme token on Sui, boasting a cutest and charming penguin mascot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3491_278b33f806.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPINGUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPINGUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


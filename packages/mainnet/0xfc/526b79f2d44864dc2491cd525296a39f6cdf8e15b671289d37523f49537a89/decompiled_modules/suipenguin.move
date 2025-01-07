module 0xfc526b79f2d44864dc2491cd525296a39f6cdf8e15b671289d37523f49537a89::suipenguin {
    struct SUIPENGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPENGUIN>(arg0, 6, b"SUIPENGUIN", b"SUIPI", b"First penguin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3491_415a8ab138.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPENGUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPENGUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


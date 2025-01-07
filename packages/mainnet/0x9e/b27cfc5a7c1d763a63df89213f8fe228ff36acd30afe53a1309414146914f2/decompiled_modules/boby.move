module 0x9eb27cfc5a7c1d763a63df89213f8fe228ff36acd30afe53a1309414146914f2::boby {
    struct BOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBY>(arg0, 6, b"Boby", b"Stray Cats", b"This cat with a story ,Its name is Boby. It was abandoned by its owner and needs your love. 30% of the tokens of this project will be used to rescue stray cats.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1899_05ffee1c87.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}


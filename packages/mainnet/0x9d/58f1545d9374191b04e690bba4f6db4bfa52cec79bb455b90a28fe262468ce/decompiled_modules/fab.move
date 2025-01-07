module 0x9d58f1545d9374191b04e690bba4f6db4bfa52cec79bb455b90a28fe262468ce::fab {
    struct FAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAB>(arg0, 6, b"FAB", b"FABULOUS PRESIDENT", b"I am honored to be you FABULOUS PRESIDENT, the 47. president of USA! Join the movement to MAKE AMERICA GREAT AGAIN and CRYPTO TO TAKE OVER THE WORLD! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bilde_09_10_2024_klokken_12_07_fc8f69f81c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAB>>(v1);
    }

    // decompiled from Move bytecode v6
}


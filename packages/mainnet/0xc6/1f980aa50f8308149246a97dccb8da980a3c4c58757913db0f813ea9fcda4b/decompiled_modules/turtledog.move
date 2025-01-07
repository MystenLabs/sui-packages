module 0xc61f980aa50f8308149246a97dccb8da980a3c4c58757913db0f813ea9fcda4b::turtledog {
    struct TURTLEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURTLEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURTLEDOG>(arg0, 6, b"TURTLEDOG", b"TurtleDog", x"545552544c45444f47206973206c69746572616c6c79206a757374206120646f6720696e206120747572746c6520636f7374756d652e20536c6f772c207374656164792c20616e64207061636b65642077697468206d656d6520656e657267792c20697473206865726520746f20637261776c206974732077617920746f2067726561746e657373206f6e652077616720617420612074696d652e0a0a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_28_13_28_06_A_funny_and_quirky_digital_illustration_of_a_dog_dressed_in_a_turtle_costume_The_dog_is_medium_sized_and_the_costume_includes_a_bright_green_turtle_5d1a5b6322.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURTLEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURTLEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}


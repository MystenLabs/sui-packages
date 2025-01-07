module 0x9331f1deab075beb0877b92acd01695549a23167ed7703373ed5d6c83bca2f31::brucelee {
    struct BRUCELEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUCELEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUCELEE>(arg0, 6, b"BruceLee", b"Bruce Lee Siu-long", b"Empty your mind, be formless shapeless like water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2022_12_01_at_1_30_59_PM_17ad5f2e09.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUCELEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUCELEE>>(v1);
    }

    // decompiled from Move bytecode v6
}


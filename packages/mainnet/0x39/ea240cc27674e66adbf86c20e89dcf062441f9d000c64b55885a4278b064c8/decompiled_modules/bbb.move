module 0x39ea240cc27674e66adbf86c20e89dcf062441f9d000c64b55885a4278b064c8::bbb {
    struct BBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBB>(arg0, 6, b"BBB", b"BBB DOG", b"YOU CANT HAVE ONE WITHOUT THE OTHER BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/92_ACED_18_2_FB_6_4_E69_8_F61_06_F1_EA_88875_A_c68cb92ca6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBB>>(v1);
    }

    // decompiled from Move bytecode v6
}


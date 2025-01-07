module 0x30d0add60c4e9238d044ca33ac4e1a28e69f1932236a861b5f57e712131a01c1::gurix {
    struct GURIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GURIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GURIX>(arg0, 6, b"GURIX", b"GURIX SUI", x"47757269783a20546865206e657765737420616e6420636f6f6c65737420636861726163746572206f662074686520417262697472756d20756e697665727365210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3j_Z7_Y_Vw9_400x400_9d50244de0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GURIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GURIX>>(v1);
    }

    // decompiled from Move bytecode v6
}


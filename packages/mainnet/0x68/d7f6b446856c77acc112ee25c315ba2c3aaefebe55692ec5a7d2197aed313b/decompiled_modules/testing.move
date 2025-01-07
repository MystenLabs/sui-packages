module 0x68d7f6b446856c77acc112ee25c315ba2c3aaefebe55692ec5a7d2197aed313b::testing {
    struct TESTING has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTING>, arg1: 0x2::coin::Coin<TESTING>) {
        0x2::coin::burn<TESTING>(arg0, arg1);
    }

    fun init(arg0: TESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTING>(arg0, 9, b"TNT", b"testing", b"Testing is the cutest $HIPPO on SUI, bringing $HIPPO to the world of memes.  No cats, no dogs. Only $HIPPO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/j2EuFh5.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTING>>(v1);
        0x2::coin::mint_and_transfer<TESTING>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTING>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


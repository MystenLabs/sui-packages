module 0x79bf060d9b3ef691abb0cd1473c02ba32714c94870a44d23fc307a0f96d0cec4::gary {
    struct GARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARY>(arg0, 6, b"GARY", b"GARY ON SUI", b"$GARY is a fun token on Sui, inspired by a wise and loyal pet snail from Spongbob. Just like this trusty snail, $GARY brings steady, dependable growth to its holders, gliding smoothly through the Sui seas. Join the journey with $GARY and explore the depths of the Sui seas!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GARY_aa3f6255b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARY>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x56486d0ba11e34ececf9405d8323525499ef8a5c260d4cbe5816043d674ec73c::mojo {
    struct MOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJO>(arg0, 6, b"MOJO", b"Mojo", b"Mojo is Matt Furie's first documented drawing, the original character that sparked his entire creative journey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blue_pig_w_text_2897f9add4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}


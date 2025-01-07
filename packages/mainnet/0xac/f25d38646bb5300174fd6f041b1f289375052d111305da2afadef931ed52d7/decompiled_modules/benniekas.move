module 0xacf25d38646bb5300174fd6f041b1f289375052d111305da2afadef931ed52d7::benniekas {
    struct BENNIEKAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENNIEKAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENNIEKAS>(arg0, 6, b"BENNIEKAS", b"Bennie", b"Bennie is all about unlocking your highest potential and infinite paws-abilities. This dreamy dog sparks creativity, brings people together, and empowers everyone to chase their goals no matter how far-fetched. Lets make it happen with Bennie!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/423423_4b11499bea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENNIEKAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENNIEKAS>>(v1);
    }

    // decompiled from Move bytecode v6
}


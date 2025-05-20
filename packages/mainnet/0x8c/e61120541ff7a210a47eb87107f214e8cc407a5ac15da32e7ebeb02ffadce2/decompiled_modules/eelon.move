module 0x8ce61120541ff7a210a47eb87107f214e8cc407a5ac15da32e7ebeb02ffadce2::eelon {
    struct EELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: EELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EELON>(arg0, 6, b"EELON", b"Ellon Sui", b"ELLON the most electric memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifqhaqqhbnnistki4ndhe2i6m3wyfpgrqeqip4wsx3odlttolki6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EELON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


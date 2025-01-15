module 0xce96ea01ac5b0aa497ac3ae218636e5ffa06111f41913d5ae462911626e39011::blup {
    struct BLUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUP>(arg0, 6, b"BLUP", b"BLUE PANTHER", b"BLUPA is an entertainment memecoin of the Blue Panther Defi platform. Join us and let's add something really interesting to the digital SUI network together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo3_155b04dc17.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUP>>(v1);
    }

    // decompiled from Move bytecode v6
}


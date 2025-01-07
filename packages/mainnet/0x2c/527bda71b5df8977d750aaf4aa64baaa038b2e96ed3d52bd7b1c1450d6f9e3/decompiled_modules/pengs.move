module 0x2c527bda71b5df8977d750aaf4aa64baaa038b2e96ed3d52bd7b1c1450d6f9e3::pengs {
    struct PENGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGS>(arg0, 6, b"PENGS", b"PENGSQUAD", b"They are small. They are wild. They are back!  Join PENGSQUAD  the real degen penguin fam!  This time, they will not stay in the shadows ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/444_04516059ca.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGS>>(v1);
    }

    // decompiled from Move bytecode v6
}


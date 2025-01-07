module 0xccfd80659d5cafb2fce1785c3cbb7815093909c481d4e1f96b0bcf872514b4ef::anon {
    struct ANON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANON>(arg0, 6, b"ANON", b"suitoshi nakamoto", b"a nod to the infamous creator of bitcoin on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7248_6dfdff4c5e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANON>>(v1);
    }

    // decompiled from Move bytecode v6
}


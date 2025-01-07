module 0x8e9894b784274c9d966f71b311a21eda2bfbd9ea416cd265899d834573413bf8::laika {
    struct LAIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAIKA>(arg0, 6, b"LAIKA", b"Laika Space Dog", b"Laika is the most famous dog in the world. the first living creature to be sent into space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fi3b8_i_A_400x400_f234326cd0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}


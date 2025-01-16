module 0x235efde22d1ebe2373663162e602cecbb429cb99535b655aa61f230804cbed72::red {
    struct RED has drop {
        dummy_field: bool,
    }

    fun init(arg0: RED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RED>(arg0, 6, b"RED", b"Red Bird", b"$RED is ready to smash! Launch it, aim high, and watch your portfolio soar!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250116_164030_795_e9f33d5f8f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RED>>(v1);
    }

    // decompiled from Move bytecode v6
}


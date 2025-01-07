module 0xc17fb6f2121cebbfc01aeb74578c2b2034aab56927752193ff75bd7afa467f3d::panpa {
    struct PANPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANPA>(arg0, 6, b"PANPA", b"Panpa On sui", b"Panpa  Journey through galaxies , exploring new worlds and dancing with stars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012453_8d3e0e0451.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANPA>>(v1);
    }

    // decompiled from Move bytecode v6
}


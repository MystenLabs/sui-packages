module 0xbfd65a1332a00fee3019a4dc166b42c3f972af962e6793b4557858d4fa27450e::moonpa {
    struct MOONPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONPA>(arg0, 6, b"MOONPA", b"Sui Moonpa", b"Moonpa  Journey through galaxies , exploring new worlds and dancing with stars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012453_b14d3896b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONPA>>(v1);
    }

    // decompiled from Move bytecode v6
}


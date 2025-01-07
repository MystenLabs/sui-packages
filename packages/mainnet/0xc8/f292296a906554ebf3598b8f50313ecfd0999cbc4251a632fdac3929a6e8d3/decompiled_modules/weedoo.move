module 0xc8f292296a906554ebf3598b8f50313ecfd0999cbc4251a632fdac3929a6e8d3::weedoo {
    struct WEEDOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEEDOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEDOO>(arg0, 6, b"WEEDOO", b"KING WEEDOO", b"King Weedoo Is heree, Is happy everyday", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kingwee_98bb2c10ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEDOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEEDOO>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xd3c5f26cb93691326cdb584f9239786d98a14baa46e1d3a197175511b0802c19::negro {
    struct NEGRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEGRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEGRO>(arg0, 6, b"NEGRO", b"Negrodamus", b"The Great Negrodamus is here to instill his infinite wisdom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_063104_4c8155fcea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEGRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEGRO>>(v1);
    }

    // decompiled from Move bytecode v6
}


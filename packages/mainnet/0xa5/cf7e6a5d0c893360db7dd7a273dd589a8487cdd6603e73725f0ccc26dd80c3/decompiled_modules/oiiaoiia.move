module 0xa5cf7e6a5d0c893360db7dd7a273dd589a8487cdd6603e73725f0ccc26dd80c3::oiiaoiia {
    struct OIIAOIIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIIAOIIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIIAOIIA>(arg0, 9, b"OIIAOIIA", b"OIIAOIIA", b"oiiaoiiaoiiaoiiaoiiaoiiaoiiaoiiaoiiaoiiaoiiaoiia cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/GCp8n4n")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OIIAOIIA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIIAOIIA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OIIAOIIA>>(v1);
    }

    // decompiled from Move bytecode v6
}


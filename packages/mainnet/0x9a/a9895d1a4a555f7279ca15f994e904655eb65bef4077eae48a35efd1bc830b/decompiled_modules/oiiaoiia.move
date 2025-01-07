module 0x9aa9895d1a4a555f7279ca15f994e904655eb65bef4077eae48a35efd1bc830b::oiiaoiia {
    struct OIIAOIIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIIAOIIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIIAOIIA>(arg0, 9, b"OIIAOIIA", b"OIIAOIIA", b"OIIAOIIAOIIAOIIAOIIAOIIAOIIAOIIAOIIAOIIAOIIAOIIAOIIAOIIAOIIAOIIA cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/GCp8n4n")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OIIAOIIA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIIAOIIA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OIIAOIIA>>(v1);
    }

    // decompiled from Move bytecode v6
}


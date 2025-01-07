module 0x1785e3c8892e8e77aed720e9384c24943038b0bd882d92cf7f2547fdde0ae1d3::slimy {
    struct SLIMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIMY>(arg0, 6, b"SLIMY", b"Sui Slimy", b"$SLIMY Make you happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_62_b4d02e0281.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIMY>>(v1);
    }

    // decompiled from Move bytecode v6
}


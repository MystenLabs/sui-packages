module 0x2d76ec479d92a4504abd609eb7eb437027e878658b730240896034a399c5f3d0::greek {
    struct GREEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEK>(arg0, 6, b"GREEK", b"Greek on SUI", b"THE MOST MEMEABLE MEMECOIN IN SUI CHAIN. THE DOGS HAVE HAD THEIR DAY, ITS TIME FOR GREEK TO TAKE REIGN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/greek_7229d51127.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREEK>>(v1);
    }

    // decompiled from Move bytecode v6
}


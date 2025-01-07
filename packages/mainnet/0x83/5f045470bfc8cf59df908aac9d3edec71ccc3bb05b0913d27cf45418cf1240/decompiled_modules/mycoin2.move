module 0x835f045470bfc8cf59df908aac9d3edec71ccc3bb05b0913d27cf45418cf1240::mycoin2 {
    struct MYCOIN2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYCOIN2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN2>(arg0, 18, b"MYCOIN2", b"my coin2", b"my coin2 desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tailwindui.com/favicon-32x32.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN2>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MYCOIN2>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}


module 0x49584cb17261014b1873142ee01bbb5d35ff78ef03ee7432fd401adeda1261d5::bender {
    struct BENDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENDER>(arg0, 8, b"BENDER", b"BENDER", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.tvtropes.org/pmwiki/pub/images/bender_coin_string.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BENDER>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENDER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENDER>>(v1);
    }

    // decompiled from Move bytecode v6
}


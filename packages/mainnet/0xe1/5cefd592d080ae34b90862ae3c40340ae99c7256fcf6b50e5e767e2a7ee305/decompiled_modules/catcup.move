module 0xe15cefd592d080ae34b90862ae3c40340ae99c7256fcf6b50e5e767e2a7ee305::catcup {
    struct CATCUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCUP>(arg0, 6, b"CATCUP", b"Cat Wif Cup", b"$CATCUP - Cat Wif Cup on da head", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catclub_027c9b7558.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATCUP>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x57a26464a2733f4978db7aed7e48d35a5365fd697e2a5950d3d9507fc0893c90::sharkui {
    struct SHARKUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKUI>(arg0, 6, b"SHARKUI", b"SHARKUISUI", b"KaUI is not just a crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiffw26w346otfcjcs2urk2b3puv2h73dvphm3whgzqw66mc5f7kaa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHARKUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


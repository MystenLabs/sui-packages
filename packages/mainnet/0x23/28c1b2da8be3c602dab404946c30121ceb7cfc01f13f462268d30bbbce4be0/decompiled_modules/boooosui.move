module 0x2328c1b2da8be3c602dab404946c30121ceb7cfc01f13f462268d30bbbce4be0::boooosui {
    struct BOOOOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOOOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOOOSUI>(arg0, 6, b"BOOOOSUI", b"BOOOO SUI", b"booooooooooooooooooooooooooooooooooooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/booo_pfp_bba74af9b3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOOOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOOOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


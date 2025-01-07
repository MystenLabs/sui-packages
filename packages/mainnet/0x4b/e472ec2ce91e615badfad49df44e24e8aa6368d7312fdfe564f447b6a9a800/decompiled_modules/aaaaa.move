module 0x4be472ec2ce91e615badfad49df44e24e8aa6368d7312fdfe564f447b6a9a800::aaaaa {
    struct AAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAA>(arg0, 6, b"AAAAA", b"AAA DOGGO", b"CANT STOP WONT STOP THINKING OF SUI AAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_52df345a1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}


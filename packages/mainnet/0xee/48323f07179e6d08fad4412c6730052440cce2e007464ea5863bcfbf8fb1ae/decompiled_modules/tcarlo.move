module 0xee48323f07179e6d08fad4412c6730052440cce2e007464ea5863bcfbf8fb1ae::tcarlo {
    struct TCARLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCARLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCARLO>(arg0, 6, b"Tcarlo", b"King Carlo", b"Now, hes got his sights on dominating SUI And he wants you in on the scheme. Think of it as strapping into a decommissioned Soviet rollercoaster  downright psychotic but man will you have a story to tell.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_31_at_9_09_55a_am_0e6442d4e5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCARLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TCARLO>>(v1);
    }

    // decompiled from Move bytecode v6
}


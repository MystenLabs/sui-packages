module 0x4bf9dc4eea61b8048c8056d73bf1d88888cd4bfffad5572b7f8bb51af38b83eb::ooo {
    struct OOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOO>(arg0, 6, b"OOO", b"Toothless a dragon", b"OOOOOOOORRRWWW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d869dcae24689dd6a76e8b77b40af749_78a3c5d5c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OOO>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x8eec08e6dd9d29810a257f1bb77525f8bc13d66945c6c9bf222bd16bf84a68cb::cddy {
    struct CDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDDY>(arg0, 6, b"CDDY", b"Craw-Diddy", b"Get ready to dive into the wild world of cryptocurrency with CrawDiddy Coin! This memecoin combines the swagger of Hip Hop Culture with the whimsy of a crawfish onesie.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crawdiddy_f46c802ec6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}


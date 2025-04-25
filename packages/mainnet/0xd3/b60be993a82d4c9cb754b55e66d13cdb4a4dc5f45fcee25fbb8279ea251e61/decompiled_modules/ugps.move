module 0xd3b60be993a82d4c9cb754b55e66d13cdb4a4dc5f45fcee25fbb8279ea251e61::ugps {
    struct UGPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UGPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UGPS>(arg0, 6, b"UGPS", b"U Got Played Scammer", b"Hi, Scammy!  I created this token just for U.  Its as worthless as U are.  I've truly enjoyed wasting Ur time and seeing how many insults I could drop on U before U gave up but U didn't.  Ur commitment to the scam is quite impressive but sorry.. U got played scammer.  Here's your reward.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/UGPS_memecoin_fa8a4df2ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UGPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UGPS>>(v1);
    }

    // decompiled from Move bytecode v6
}


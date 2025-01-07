module 0xdc9e397fa94467d794f17527297d818bdc8eb6a6ee689864b7a2f4fcee770840::dbuy {
    struct DBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBUY>(arg0, 6, b"DBUY", b"Don't Buy", b"What is Don't Buy ($DBUY)? The ultimate reverse psychology token! Created for those who love to be told what to do (and then do the opposite), the $DBUY token dares you to resist temptation. The only utility? Testing your willpower. No roadmap, no utility, no partnershipsjust pure fun as the community rallies around doing exactly what theyre told not to. A meme token for the rebellious at heart! You know you shouldn't buy... but will you?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_6526fcb3e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBUY>>(v1);
    }

    // decompiled from Move bytecode v6
}


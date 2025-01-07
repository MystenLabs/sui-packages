module 0x9962151042508567181187c60c3af01f3ccb111645d9188bed8d76208dbaa105::aaaaratt {
    struct AAAARATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAARATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAARATT>(arg0, 6, b"AaaaRatt", b"Aaa Rat", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaaRatt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/00_f69c225725.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAARATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAARATT>>(v1);
    }

    // decompiled from Move bytecode v6
}


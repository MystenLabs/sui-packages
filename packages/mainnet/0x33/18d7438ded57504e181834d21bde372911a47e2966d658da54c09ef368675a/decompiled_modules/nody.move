module 0x3318d7438ded57504e181834d21bde372911a47e2966d658da54c09ef368675a::nody {
    struct NODY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NODY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NODY>(arg0, 6, b"NODY", b"NO DIDDY", b"Come join the No Diddy Community as we go throughout his whole Rico Case.We will reach numbers like no others as community grows.REMEMBER THERES NO PARTY LIKE A DIDDY PARTY. NO DIDDY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6241_ee5a6e2089.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NODY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NODY>>(v1);
    }

    // decompiled from Move bytecode v6
}


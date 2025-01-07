module 0xb9eb2b92590604c4ca00613fbcf079f952941f5fd8d626cd5a6b53ad3624bcf::amber {
    struct AMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMBER>(arg0, 6, b"AMBER", b"Amber", b"The $AMBER token serves as a tool for interaction within the AmberSUI ecosystem, allowing users to earn rewards for participating in projects, improving, and testing applications.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ambr_c1c006ca8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}


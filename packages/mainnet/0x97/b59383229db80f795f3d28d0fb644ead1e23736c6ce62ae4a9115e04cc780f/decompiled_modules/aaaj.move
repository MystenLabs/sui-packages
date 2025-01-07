module 0x97b59383229db80f795f3d28d0fb644ead1e23736c6ce62ae4a9115e04cc780f::aaaj {
    struct AAAJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAJ>(arg0, 6, b"aaaJ", b"aaa I JEETED again!", x"73746f70206a656574696e6720666f722070656e6e6965732e20736974206261636b2c2062757920246161614a2c20686f6c6420616e6420636f6c6c65637420796f757220666972737420313030782e0a0a616c7265616479207665726966696564206f6e2058202f20547769747465722e204c657473207075736820697421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_98_48776eb1e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAJ>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xdc704e7b56f3bee479b81c2163d4f67225b77ae6969fc9541bee6f1e2d14b752::dappy {
    struct DAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAPPY>(arg0, 6, b"DAPPY", b"DAPPY  SUI", b"GOBLIN PIRATE ENGINEER ON A HUNT FOR WHALES AND KOLS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_44_cb6c73af64.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}


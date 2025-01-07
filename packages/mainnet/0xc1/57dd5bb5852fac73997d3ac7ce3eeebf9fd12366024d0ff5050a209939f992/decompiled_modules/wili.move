module 0xc157dd5bb5852fac73997d3ac7ce3eeebf9fd12366024d0ff5050a209939f992::wili {
    struct WILI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILI>(arg0, 6, b"WiLi", b"WildLife", b"For wildlife.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wildlife_e16ad0271d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILI>>(v1);
    }

    // decompiled from Move bytecode v6
}


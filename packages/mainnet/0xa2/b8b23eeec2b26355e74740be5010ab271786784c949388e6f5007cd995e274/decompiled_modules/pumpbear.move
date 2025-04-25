module 0xa2b8b23eeec2b26355e74740be5010ab271786784c949388e6f5007cd995e274::pumpbear {
    struct PUMPBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPBEAR>(arg0, 6, b"PUMPBEAR", b"Pumpbear", x"4d656574202450554d50424541522074686174206f6e6c79206b6e6f777320677265656e2063616e646c65732e2050756d70626561722069732061206861726d6c65737320626561722074686174206c696b657320746f2077726573746c6520616e642070756d702e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pumpbearlogo_bd2f5f0d26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}


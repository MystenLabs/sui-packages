module 0x842639784a5d3376ee8ddd2247cda2f33615b470e6653b5c388a1ef58cb434ba::wog {
    struct WOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOG>(arg0, 6, b"WOG", b"Whale Dog", b"definitely not a dog - lets actually send this one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pm_pp_26fb21af82.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOG>>(v1);
    }

    // decompiled from Move bytecode v6
}


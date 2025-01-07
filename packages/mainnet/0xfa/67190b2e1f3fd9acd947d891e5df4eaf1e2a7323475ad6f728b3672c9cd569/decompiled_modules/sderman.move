module 0xfa67190b2e1f3fd9acd947d891e5df4eaf1e2a7323475ad6f728b3672c9cd569::sderman {
    struct SDERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDERMAN>(arg0, 6, b"sDERMAN", b"SUIDERMAN", b"SUIDERMAN WITH US", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001133_28e406b478.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}


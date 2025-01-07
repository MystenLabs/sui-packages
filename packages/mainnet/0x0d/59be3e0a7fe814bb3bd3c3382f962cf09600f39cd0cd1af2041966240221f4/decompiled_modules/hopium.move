module 0xd59be3e0a7fe814bb3bd3c3382f962cf09600f39cd0cd1af2041966240221f4::hopium {
    struct HOPIUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPIUM>(arg0, 6, b"HOPIum", b"HOPIum SUI", b"The hilariously clueless hippo who always gets into ridiculous jungle mishaps! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hopi_chef_7cb363ec81.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPIUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPIUM>>(v1);
    }

    // decompiled from Move bytecode v6
}


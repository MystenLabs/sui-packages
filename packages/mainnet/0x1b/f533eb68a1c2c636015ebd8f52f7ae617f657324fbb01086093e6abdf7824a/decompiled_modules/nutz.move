module 0x1bf533eb68a1c2c636015ebd8f52f7ae617f657324fbb01086093e6abdf7824a::nutz {
    struct NUTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTZ>(arg0, 6, b"NUTZ", b"Sui Nutz Pad", b"SUI Nutz Pad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Xp_Bnz_DAH_400x400_7791cca661.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUTZ>>(v1);
    }

    // decompiled from Move bytecode v6
}


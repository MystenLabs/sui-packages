module 0x2b878de0b6563b8f33d8e658bfb94cedc751f6c916b4be7e56a3e9657fbfde55::boy {
    struct BOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOY>(arg0, 6, b"BOY", b"Good Boy", b"Just a good $boy on SUI. CTO  https://t.me/boydoggo https://goodboysol.net", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/H74_D_Eqfu_400x400_1_57b7a0aef3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOY>>(v1);
    }

    // decompiled from Move bytecode v6
}


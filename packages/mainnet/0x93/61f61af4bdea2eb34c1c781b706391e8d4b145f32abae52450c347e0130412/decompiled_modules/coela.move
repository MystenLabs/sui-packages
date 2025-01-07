module 0x9361f61af4bdea2eb34c1c781b706391e8d4b145f32abae52450c347e0130412::coela {
    struct COELA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COELA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COELA>(arg0, 6, b"COELA", b"Coela", b"Coela is at the bottom of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ciera_icon_89f86fb705.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COELA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COELA>>(v1);
    }

    // decompiled from Move bytecode v6
}


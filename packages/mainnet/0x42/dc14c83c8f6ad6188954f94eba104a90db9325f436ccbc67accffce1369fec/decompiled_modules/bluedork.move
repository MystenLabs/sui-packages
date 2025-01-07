module 0x42dc14c83c8f6ad6188954f94eba104a90db9325f436ccbc67accffce1369fec::bluedork {
    struct BLUEDORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEDORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDORK>(arg0, 6, b"BlueDork", b"BLUE DORK LORD", b"DORK LORD BY MATT FURIE ON SUI https://www.dorksui.vip/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3852_e808463782.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEDORK>>(v1);
    }

    // decompiled from Move bytecode v6
}


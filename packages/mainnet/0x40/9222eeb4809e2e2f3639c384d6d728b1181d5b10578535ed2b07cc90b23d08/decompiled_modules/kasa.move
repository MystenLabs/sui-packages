module 0x409222eeb4809e2e2f3639c384d6d728b1181d5b10578535ed2b07cc90b23d08::kasa {
    struct KASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KASA>(arg0, 6, b"KASA", b"KASAS", b"KSASSASS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/discord_icon_2048x2048_o5mluhz2_5633754e1a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KASA>>(v1);
    }

    // decompiled from Move bytecode v6
}


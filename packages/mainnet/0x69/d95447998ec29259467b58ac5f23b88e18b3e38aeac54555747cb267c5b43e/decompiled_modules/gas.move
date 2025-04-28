module 0x69d95447998ec29259467b58ac5f23b88e18b3e38aeac54555747cb267c5b43e::gas {
    struct GAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAS>(arg0, 6, b"GAS", b"BLUE GAS", b"we fart too here on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745846422016.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


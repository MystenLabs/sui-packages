module 0x5d92690c562a4a9802e69a511a49916d1e852ea4ccb17fd74afe48c91fcded99::trilelon {
    struct TRILELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRILELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRILELON>(arg0, 6, b"TRILELON", b"TrilElon", b"TRILLIONAIRE ELON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732440158128.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRILELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRILELON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


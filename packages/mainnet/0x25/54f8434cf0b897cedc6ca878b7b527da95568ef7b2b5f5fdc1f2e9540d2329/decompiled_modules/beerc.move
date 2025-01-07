module 0x2554f8434cf0b897cedc6ca878b7b527da95568ef7b2b5f5fdc1f2e9540d2329::beerc {
    struct BEERC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEERC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEERC>(arg0, 9, b"BEERC", b"BeerCoin", b"Nice nice beer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d456501a-61d9-4164-86cb-a02a4d06bc90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEERC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEERC>>(v1);
    }

    // decompiled from Move bytecode v6
}


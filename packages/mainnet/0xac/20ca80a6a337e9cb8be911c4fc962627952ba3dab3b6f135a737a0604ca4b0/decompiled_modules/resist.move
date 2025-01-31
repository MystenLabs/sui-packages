module 0xac20ca80a6a337e9cb8be911c4fc962627952ba3dab3b6f135a737a0604ca4b0::resist {
    struct RESIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: RESIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESIST>(arg0, 6, b"RESIST", b"Resist AI", x"245245534953542073796d626f6c697a657320746865207265667573616c20746f2073757272656e646572206f757220756e697175656e65737320746f2074686520746964616c2077617665206f6620414920746563686e6f6c6f67792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738345570858.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESIST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RESIST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


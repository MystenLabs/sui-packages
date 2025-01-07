module 0x4e6085440012460600178b9b0930d29d257dfb1a1a9a38ef0c0b5e05ad51ab58::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"Suishi", b"Suishii", b"Have a Taste of Success", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734190468516.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x1be2ad0fd324c1164bf8c842abc4b28efa4352160d7800255e76c2db258421b9::boi {
    struct BOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOI>(arg0, 6, b"BOI", b"boi", b"good boi of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959593482.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


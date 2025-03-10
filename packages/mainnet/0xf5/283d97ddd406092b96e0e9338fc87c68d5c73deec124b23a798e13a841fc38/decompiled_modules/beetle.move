module 0xf5283d97ddd406092b96e0e9338fc87c68d5c73deec124b23a798e13a841fc38::beetle {
    struct BEETLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEETLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEETLE>(arg0, 6, b"BEETLE", b"BeetleJuice", x"576520616c6c206c6f76652074686973206d656d652c207468697320746f6b656e206973206a75737420666f722066756e20616e642066756c6c7920636f6d6d756e6974792064726976656e2e0a0a4a7573742068616e67696e672061726f756e642e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1741640387603.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEETLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEETLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


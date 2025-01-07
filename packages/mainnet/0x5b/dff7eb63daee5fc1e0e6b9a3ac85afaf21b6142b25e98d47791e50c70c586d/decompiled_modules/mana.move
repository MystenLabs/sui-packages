module 0x5bdff7eb63daee5fc1e0e6b9a3ac85afaf21b6142b25e98d47791e50c70c586d::mana {
    struct MANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANA>(arg0, 6, b"MANA", b"MANATEE SUI", x"446f6e277420666f7267657420746f206272696e672061204d616e6174656520210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731169674256.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


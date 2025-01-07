module 0x61a597a80163851c407d25ade3f3297bca2355786ff960ba2fe7ce1fba5809e7::bonkman {
    struct BONKMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKMAN>(arg0, 6, b"Bonkman", b"Sad Bonkman", x"426f6e6b6d616e206973207361642062656361757365206865206e6565647320616e6f746865722035206461797320746f206c6561726e2070726f6772616d6d696e67203a280a4c657427732068656c702068696d20616e64206170652053616420426f6e6b6d616e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730975529299.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONKMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


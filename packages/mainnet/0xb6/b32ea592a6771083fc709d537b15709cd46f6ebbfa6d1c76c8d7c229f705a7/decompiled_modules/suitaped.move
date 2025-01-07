module 0xb6b32ea592a6771083fc709d537b15709cd46f6ebbfa6d1c76c8d7c229f705a7::suitaped {
    struct SUITAPED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAPED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAPED>(arg0, 6, b"SUItaped", b"duck-taped Sui", b"there must be something in the sea that can rise up to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732321438471.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITAPED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAPED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x5605b63064d9520872429fa1d741c561ede742f89efc9a49ee89a3279877a00f::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE>(arg0, 6, b"LUCE", b"LUCES", b"LUCE ONN SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731709337205.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


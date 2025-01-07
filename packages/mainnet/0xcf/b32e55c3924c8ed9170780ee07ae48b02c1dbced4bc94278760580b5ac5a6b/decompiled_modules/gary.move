module 0xcfb32e55c3924c8ed9170780ee07ae48b02c1dbced4bc94278760580b5ac5a6b::gary {
    struct GARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARY>(arg0, 6, b"GARY", b"garyonsui", b"07/11/2024 gary was launched ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950372729.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GARY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


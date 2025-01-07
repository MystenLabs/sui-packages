module 0xd22003ad28deb433559ae4334f77795542b1338b0a90f8cc3f31b554ff0154ff::stbuui {
    struct STBUUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STBUUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STBUUI>(arg0, 6, b"STBUUI", b"STBU", b"STBU123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955068518.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STBUUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STBUUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


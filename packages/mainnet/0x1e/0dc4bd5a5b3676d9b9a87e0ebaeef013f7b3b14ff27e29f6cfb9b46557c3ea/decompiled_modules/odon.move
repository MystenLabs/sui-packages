module 0x1e0dc4bd5a5b3676d9b9a87e0ebaeef013f7b3b14ff27e29f6cfb9b46557c3ea::odon {
    struct ODON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODON>(arg0, 6, b"ODON", b"SUIODON", b"https://x.com/SuiOdon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959141705.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ODON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


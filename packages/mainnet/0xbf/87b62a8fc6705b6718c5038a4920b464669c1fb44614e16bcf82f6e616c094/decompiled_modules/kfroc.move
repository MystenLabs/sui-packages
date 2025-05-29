module 0xbf87b62a8fc6705b6718c5038a4920b464669c1fb44614e16bcf82f6e616c094::kfroc {
    struct KFROC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFROC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFROC>(arg0, 6, b"KFROC", b"KfrocOnSui", b"The frog king is KFROC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000074633_d49c7d07c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFROC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KFROC>>(v1);
    }

    // decompiled from Move bytecode v6
}


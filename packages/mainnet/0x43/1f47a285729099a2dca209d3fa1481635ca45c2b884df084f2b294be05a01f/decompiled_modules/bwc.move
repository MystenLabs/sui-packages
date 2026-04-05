module 0x431f47a285729099a2dca209d3fa1481635ca45c2b884df084f2b294be05a01f::bwc {
    struct BWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWC>(arg0, 6, b"BWC", b"Big White Cod", b"The biggest white cod. Stronger and longer, here to keep SUI safe from unwanted attacks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1775394882608.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BWC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


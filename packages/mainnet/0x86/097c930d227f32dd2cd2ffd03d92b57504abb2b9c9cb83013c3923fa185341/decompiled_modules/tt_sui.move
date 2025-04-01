module 0x86097c930d227f32dd2cd2ffd03d92b57504abb2b9c9cb83013c3923fa185341::tt_sui {
    struct TT_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT_SUI>(arg0, 9, b"ttSUI", b"TEST1 SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Test-Logo.svg/2560px-Test-Logo.svg.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TT_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xf0aa3ccf844aacad817ec224d6d76867d9090ba215accadf51664264a6d8fa4e::yho {
    struct YHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YHO>(arg0, 9, b"YHO", b"YahsOwn", b"More than you can ever imagine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/223073c7-2705-4b97-a7b8-90a7cc26b572.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YHO>>(v1);
    }

    // decompiled from Move bytecode v6
}


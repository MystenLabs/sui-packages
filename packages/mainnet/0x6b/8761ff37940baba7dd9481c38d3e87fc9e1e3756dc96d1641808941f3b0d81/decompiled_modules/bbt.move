module 0x6b8761ff37940baba7dd9481c38d3e87fc9e1e3756dc96d1641808941f3b0d81::bbt {
    struct BBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBT>(arg0, 9, b"BBT", b"boat", b"riding the waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9dbea4e9-6b07-4b5b-a5a2-3803e10d8c06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBT>>(v1);
    }

    // decompiled from Move bytecode v6
}


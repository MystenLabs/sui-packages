module 0xacf835dae34b4cc7dc088571026b644393558c95b9eed644595ade2dae527dba::ask {
    struct ASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASK>(arg0, 9, b"ASK", b"ASKOLDIA", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a28b86c-5720-4c1a-9c4b-84bcf30999ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASK>>(v1);
    }

    // decompiled from Move bytecode v6
}


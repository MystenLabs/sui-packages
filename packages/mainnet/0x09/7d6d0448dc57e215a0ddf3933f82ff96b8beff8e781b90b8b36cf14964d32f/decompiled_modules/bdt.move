module 0x97d6d0448dc57e215a0ddf3933f82ff96b8beff8e781b90b8b36cf14964d32f::bdt {
    struct BDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDT>(arg0, 9, b"BDT", b"BD TAKA ", x"42616e676c6164657368692063757272656e637920f09f87a7f09f87a9f09f92b2f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b57de76-cb68-45ee-aaff-a9a8afd9f928.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDT>>(v1);
    }

    // decompiled from Move bytecode v6
}


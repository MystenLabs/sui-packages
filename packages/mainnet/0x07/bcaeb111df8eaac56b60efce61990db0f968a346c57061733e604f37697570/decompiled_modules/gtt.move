module 0x7bcaeb111df8eaac56b60efce61990db0f968a346c57061733e604f37697570::gtt {
    struct GTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTT>(arg0, 9, b"GTT", b"GiangThen", b"GTT TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62ccf652-30ca-4c99-8d97-d675ce8a5663.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTT>>(v1);
    }

    // decompiled from Move bytecode v6
}


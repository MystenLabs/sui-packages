module 0xbc49c4c083ab24beca06d4da6f71fe63476b162426e054ad7b70697faddffa1e::blocks {
    struct BLOCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOCKS>(arg0, 6, b"BLOCKS", b"THE BLOCKS", x"54686520666972737420746f7973206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731161332178.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOCKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOCKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


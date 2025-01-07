module 0xb34fa9d6efdc31fd4bddc7e26591fd87ec673500584588b59d0b6c9461ee1bbc::dgo {
    struct DGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGO>(arg0, 9, b"DGO", b"babz dog", x"4d616e2773206265737420667269656e640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9882f17a-c1ef-46a8-b896-b7e9dd30a293.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGO>>(v1);
    }

    // decompiled from Move bytecode v6
}


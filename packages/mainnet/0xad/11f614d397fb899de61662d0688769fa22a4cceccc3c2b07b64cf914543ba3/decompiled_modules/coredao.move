module 0xad11f614d397fb899de61662d0688769fa22a4cceccc3c2b07b64cf914543ba3::coredao {
    struct COREDAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COREDAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COREDAO>(arg0, 9, b"COREDAO", b"Core", b"New btc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54fa684c-40d3-43e3-ad15-9bb4fb8354f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COREDAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COREDAO>>(v1);
    }

    // decompiled from Move bytecode v6
}


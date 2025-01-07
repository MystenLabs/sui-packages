module 0xdbbff2471f3bdbb71f2a6475c0292d2fd1bdabc345bea220062a2af670460c99::nao {
    struct NAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAO>(arg0, 6, b"NAO", b"Sui Nao", b"$NAO swims through the sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_72_1bad73ab7d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAO>>(v1);
    }

    // decompiled from Move bytecode v6
}


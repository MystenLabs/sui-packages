module 0x37c105f9aa5c58896cdc3cb62776dc78899c1c847cbac80a066e5672c8669fcd::punksui {
    struct PUNKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNKSUI>(arg0, 6, b"PUNKSUI", b"PUNKS SUI", b"The NFT Collection That Proves You Are One Of The Ogs In The Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_024053917_7b27c02578.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUNKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x6caf52d1fb96c620f0c30d459d7f067a94c1d48ba5fdddc1b2ba7b931b6853ce::kett {
    struct KETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KETT>(arg0, 6, b"Kett", b"Kett Sui", b"Blue Kett", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaj5fz75ig446adsnxtxwirn3qnv5k6cge5du6k3fbkiyakmkyhaa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KETT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


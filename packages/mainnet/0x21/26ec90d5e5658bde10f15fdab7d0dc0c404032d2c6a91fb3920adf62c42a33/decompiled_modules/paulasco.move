module 0x2126ec90d5e5658bde10f15fdab7d0dc0c404032d2c6a91fb3920adf62c42a33::paulasco {
    struct PAULASCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAULASCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAULASCO>(arg0, 9, b"PAULASCO", b"Paul", b"Token of dm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7260dd0a-f7c4-4134-89a9-984b0a95baae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAULASCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAULASCO>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xbb248da119180f1cc68ce5dce63b651616d250f2771cd70b57d4f87e084d998d::sks {
    struct SKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKS>(arg0, 9, b"SKS", b"Suikillsol", b"Sui will be the Solana killer.SKS is just a Meme to see how far it can go and widespread .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad067a30-45c9-464b-81f3-9fb3c71613ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKS>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x11089d49b1c3a98c5749eb8a142b8f7e71c4da758c4b9c74dc20647763ac48e4::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIT>(arg0, 9, b"SHIT", b"ShitCoin", b"ShitCoin is here to prove that even the crappiest ideas can make you rich. This tongue-in-cheek token takes the market by storm, offering humor and ridiculous returns. Invest in ShitCoin and let's see just how far this joke can go. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d18edfd-fc9e-4725-8c68-e07b66835656.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}


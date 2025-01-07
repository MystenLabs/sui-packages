module 0x9805826bb4210def7f46e598ad1bc2ed7dae2fa240ce17dcfc2b0f30a4ff15b7::biw {
    struct BIW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIW>(arg0, 9, b"BIW", b"billow", b"wave. especially : a great wave or surge of water. the rolling billows of the sea. 2. : a rolling mass (as of flame or smoke) that resembles a high wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46702a8e-809a-48af-8fb5-05dafb46ede0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIW>>(v1);
    }

    // decompiled from Move bytecode v6
}


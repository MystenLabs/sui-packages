module 0x7c1e0c7e37a0d411ebd6c063bcab5d82f725b9251b2ba16664ab3de11afd857d::frien {
    struct FRIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIEN>(arg0, 9, b"FRIEN", b"Frieren AI", b"Frieren is meme coin on Sui network,this coin is connecting between anime and sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5334779b-3768-4ff0-bb7e-a09909504abf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x3fa9a780df7bda1f9bf34be9d7dc825af19914adee5325c2c7352cd38d7a459d::pawx {
    struct PAWX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWX>(arg0, 9, b"PAWX", b"PAW Pixel", b"Proof of Pets that will be symbolize for all animal meme genre. Get it as early investor ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c15859c-73f3-4a82-a58f-81892fc83cda-pixi_avatar_1728067530839.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWX>>(v1);
    }

    // decompiled from Move bytecode v6
}


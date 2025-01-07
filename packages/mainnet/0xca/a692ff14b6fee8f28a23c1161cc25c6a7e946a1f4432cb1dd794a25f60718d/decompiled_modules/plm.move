module 0xcaa692ff14b6fee8f28a23c1161cc25c6a7e946a1f4432cb1dd794a25f60718d::plm {
    struct PLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLM>(arg0, 9, b"PLM", b"palm", b"Get ready to palm with palmCoin: The meme-powered crypto that turns laughter into a valuable asset, one joke at a time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f35675ad-ed54-418f-9d92-83c96d80029b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLM>>(v1);
    }

    // decompiled from Move bytecode v6
}


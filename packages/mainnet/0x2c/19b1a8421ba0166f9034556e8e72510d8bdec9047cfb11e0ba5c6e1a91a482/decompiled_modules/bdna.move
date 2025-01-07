module 0x2c19b1a8421ba0166f9034556e8e72510d8bdec9047cfb11e0ba5c6e1a91a482::bdna {
    struct BDNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDNA>(arg0, 9, b"BDNA", b"Bebe", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb150904-41bc-4c91-a95d-320c19ec69b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDNA>>(v1);
    }

    // decompiled from Move bytecode v6
}


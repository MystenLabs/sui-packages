module 0x35093e887c86e6e39f8034b708d784d83ed871ad592b388076ed9e0d8f0a734d::suimoray {
    struct SUIMORAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMORAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMORAY>(arg0, 6, b"SuiMoray", b"Moray Eel", b"Introducing Moray Eel, the newest and most electrifying meme token on the Sui blockchain! Moray Eel is a unique and innovative meme token that is sure to shake up the memecoin market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7261_98c9e15aa0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMORAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMORAY>>(v1);
    }

    // decompiled from Move bytecode v6
}


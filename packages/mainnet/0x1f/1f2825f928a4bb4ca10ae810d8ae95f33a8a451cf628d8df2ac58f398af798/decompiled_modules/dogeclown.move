module 0x1f1f2825f928a4bb4ca10ae810d8ae95f33a8a451cf628d8df2ac58f398af798::dogeclown {
    struct DOGECLOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGECLOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGECLOWN>(arg0, 6, b"DogeClown", b"Doge Clown on Sui", b"Doge Clown is the main brand coin of Sui Network: Onboard Users. Maximize Memes. Strengthen Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dc_f5ea6878a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGECLOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGECLOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x7ea2953dda1a8556dce250a7cff7363c6a552a91bd86deb795960d8b23e997a7::play {
    struct PLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAY>(arg0, 6, b"PLAY", b"Play on Sui", x"412066756e206d656d6520636f696e2c206d616465206279205375692066616e0a547769747465722d736f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046303_7a013e3025.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLAY>>(v1);
    }

    // decompiled from Move bytecode v6
}


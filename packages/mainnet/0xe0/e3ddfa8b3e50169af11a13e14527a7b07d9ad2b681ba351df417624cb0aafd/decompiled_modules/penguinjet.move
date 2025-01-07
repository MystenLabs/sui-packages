module 0xe0e3ddfa8b3e50169af11a13e14527a7b07d9ad2b681ba351df417624cb0aafd::penguinjet {
    struct PENGUINJET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUINJET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUINJET>(arg0, 6, b"PENGUINJET", b"PENGUIN JET", b"PENGUINJET is the fun, fast, and fearless meme coin that's redefining the crypto game. Inspired by the daring spirit of a rocket-fueled penguin, this community-driven token is built for speed, accessibility, and an adventurous journey to success.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/777_3a62ea7fef.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUINJET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGUINJET>>(v1);
    }

    // decompiled from Move bytecode v6
}


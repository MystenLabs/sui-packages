module 0xdd9ce5afb4d33187d4a44482eb6e683507c235404c619b7a1e553a0ae4e85e13::colors {
    struct COLORS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLORS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLORS>(arg0, 6, b"COLORS", b"COLORS COIN", b"Colors Coin The Meme Token That Paints the Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreianpvurpe2osiakjcjss76vkccpxyc6fqlhrkfh4h74urs636oe6i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLORS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COLORS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


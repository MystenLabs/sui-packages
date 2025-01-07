module 0xf8ea789c9b91035908dd24ebbfcc38d7d37295f2bf4fb0ae4c27ac939f0ae53d::dogi {
    struct DOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGI>(arg0, 9, b"DOGI", b"Dogi", b"Dogi is a Meme Dog Token designed for the Sui community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0130f3c-6ce9-45bc-87c4-c3fe4b2c6a27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}


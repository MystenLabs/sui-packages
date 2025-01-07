module 0x8c1ee6a00aa6e93cf6af17e5325989ee93156a17db196bcaa774446663241efa::obj {
    struct OBJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBJ>(arg0, 9, b"OBJ", b"OBIGEEK", b"EARN MORE MONEY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea2dfe28-8a81-4f02-adaf-07be810c00ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBJ>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x530e2d56e63a3079c2319b7d38b5315d224c6c6aed1bdd99f08e091ccc2079ef::gb {
    struct GB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GB>(arg0, 9, b"GB", b"GummyBear", b"Just the bear, but gummy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d39e704-3359-4143-953d-bc9f366f7ba4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GB>>(v1);
    }

    // decompiled from Move bytecode v6
}


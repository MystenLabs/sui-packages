module 0x5383dd7b4a540ba00b9b9131ebcb03dd75565f79f9eb0d551c936560de7e13e4::sji {
    struct SJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJI>(arg0, 9, b"SJI", b"Saiji", b"Purely meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ca8132c-88ca-474b-b2df-32ea77bd17bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SJI>>(v1);
    }

    // decompiled from Move bytecode v6
}


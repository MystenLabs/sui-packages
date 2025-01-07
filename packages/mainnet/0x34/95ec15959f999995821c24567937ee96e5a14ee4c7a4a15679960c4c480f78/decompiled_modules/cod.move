module 0x3495ec15959f999995821c24567937ee96e5a14ee4c7a4a15679960c4c480f78::cod {
    struct COD has drop {
        dummy_field: bool,
    }

    fun init(arg0: COD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COD>(arg0, 9, b"COD", b"C OF D", b"CALL OF DUTY FANS ARE BUYING THIS MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8f8879b-4ca6-4e0f-b497-7371be0afb98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COD>>(v1);
    }

    // decompiled from Move bytecode v6
}


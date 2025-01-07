module 0x8e9b94d63a7940b25f4297a611d0510dc0e9d8cf4efedd58a0eaa5714d0909eb::ibm {
    struct IBM has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBM>(arg0, 9, b"IBM", b"ICE BAMA", b"WOK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5705915-abeb-4393-bcfc-9a088a947b91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IBM>>(v1);
    }

    // decompiled from Move bytecode v6
}


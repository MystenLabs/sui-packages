module 0x755f47420aa659743d08838c3b3b9884e75bf2f4afad77ae5c5f50889b3bbd0a::waves {
    struct WAVES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVES>(arg0, 9, b"WAVES", b"Wave", b"Wave on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16eb745f-5d10-4e70-9439-08d897811b94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVES>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x9815ae638dcbe0172385abde6c41807acc18fb05748dc8d46819064391bdb819::xxx {
    struct XXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XXX>(arg0, 9, b"XXX", b"Xxx1", b"Xxx2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bde9e27e-6758-40ae-8d1a-52368f40e694.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XXX>>(v1);
    }

    // decompiled from Move bytecode v6
}


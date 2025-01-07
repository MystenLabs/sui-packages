module 0xb5bef56d09c87e21c7375e16c8554829c910882edbb2c6d37c49e0f8b7899469::rbn {
    struct RBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBN>(arg0, 9, b"RBN", b"Roben", b"Coolest token on planet. Don't miss it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a15cd50f-ba4b-448b-9c61-811073363477.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBN>>(v1);
    }

    // decompiled from Move bytecode v6
}


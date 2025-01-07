module 0x3a29d922d02035f57d7ffb522fcf134290aad4d61141e1f2055a4ba88d775844::uc {
    struct UC has drop {
        dummy_field: bool,
    }

    fun init(arg0: UC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UC>(arg0, 9, b"UC", b"PUBG", b"https://t.me/terminalgame_bot/terminalgame?startapp=VO8YE13A&startApp=VO8YE13A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b67bbd94-d5df-4468-b4ff-2c5586c2b127.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UC>>(v1);
    }

    // decompiled from Move bytecode v6
}


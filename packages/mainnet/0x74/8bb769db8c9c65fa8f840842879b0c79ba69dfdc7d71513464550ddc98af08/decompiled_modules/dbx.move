module 0x748bb769db8c9c65fa8f840842879b0c79ba69dfdc7d71513464550ddc98af08::dbx {
    struct DBX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBX>(arg0, 9, b"DBX", b"DragonBuck", b"Fierce gains, dragon fire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79ee608a-0f09-4d48-8411-c84e9fd75e81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DBX>>(v1);
    }

    // decompiled from Move bytecode v6
}


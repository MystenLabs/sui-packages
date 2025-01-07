module 0x8e2869631553af2cfeedf6fdfed7074544e86a916a112f6744ee5f7048669907::squirry {
    struct SQUIRRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRRY>(arg0, 9, b"SQUIRRY", b"SQUIRREL", b"Squirrel token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/909f4085-f3f6-4dbc-88f1-0b6146809800.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUIRRY>>(v1);
    }

    // decompiled from Move bytecode v6
}


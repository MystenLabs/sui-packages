module 0x4e5841debe2b4c078d690e02324820a553b07b34f361e4e259433702a835e407::labubu {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 9, b"LABUBU", b"Labubu", b"Labubu is described as a tiny little monster with a cute appearance, featuring large round eyes and sharp fangs, yet it creates a sense of closeness and friendliness for its fans.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/252f5319-e253-42f6-b440-cae80993252c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}


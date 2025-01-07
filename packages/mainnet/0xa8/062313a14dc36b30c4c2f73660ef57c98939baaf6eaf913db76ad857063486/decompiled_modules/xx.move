module 0xa8062313a14dc36b30c4c2f73660ef57c98939baaf6eaf913db76ad857063486::xx {
    struct XX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XX>(arg0, 9, b"XX", b"Xuxu", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d20fbde6-fa95-4e6a-97e3-179779a75d31.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XX>>(v1);
    }

    // decompiled from Move bytecode v6
}


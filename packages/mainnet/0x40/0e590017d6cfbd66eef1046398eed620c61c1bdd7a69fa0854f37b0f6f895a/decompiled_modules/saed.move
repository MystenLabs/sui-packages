module 0x400e590017d6cfbd66eef1046398eed620c61c1bdd7a69fa0854f37b0f6f895a::saed {
    struct SAED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAED>(arg0, 9, b"SAED", b"Saeed", b"Ghruejbebd hfjdjdb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/592112b8-16d5-44e5-aa32-427ab8334f65.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAED>>(v1);
    }

    // decompiled from Move bytecode v6
}


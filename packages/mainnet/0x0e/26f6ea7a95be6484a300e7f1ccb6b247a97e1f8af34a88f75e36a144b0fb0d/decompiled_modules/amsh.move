module 0xe26f6ea7a95be6484a300e7f1ccb6b247a97e1f8af34a88f75e36a144b0fb0d::amsh {
    struct AMSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMSH>(arg0, 9, b"AMSH", b"Amsha", b"Symbol for love and Compassion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7eacafb5-bd27-48f3-bfc5-1b66ebe1c003.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMSH>>(v1);
    }

    // decompiled from Move bytecode v6
}


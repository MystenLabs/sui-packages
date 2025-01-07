module 0x5de70c80424e0c24f73be37463cbdce4ff568ee29d1df25efd8143deb2b8df69::dd {
    struct DD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DD>(arg0, 9, b"DD", b"Hhd", b"Ddhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d6c6c89-5ed0-4600-90df-49434f5a2911.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DD>>(v1);
    }

    // decompiled from Move bytecode v6
}


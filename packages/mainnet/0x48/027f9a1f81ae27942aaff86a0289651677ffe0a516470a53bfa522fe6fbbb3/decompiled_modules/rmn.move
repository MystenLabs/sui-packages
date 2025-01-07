module 0x48027f9a1f81ae27942aaff86a0289651677ffe0a516470a53bfa522fe6fbbb3::rmn {
    struct RMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMN>(arg0, 9, b"RMN", b"Ramen", b"Meme coins created with @SuiNetwork at Wave Trading.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da08d767-0597-499f-88bd-8f89bf1b3b3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RMN>>(v1);
    }

    // decompiled from Move bytecode v6
}


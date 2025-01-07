module 0x5e346a516680a796120c0826d720079f7537fe2f3abf1111dac394013db17349::we {
    struct WE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WE>(arg0, 9, b"WE", b"WEAQ", b"12378956", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/937cac78-6c69-4fbb-8ad4-9ab99d86158a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WE>>(v1);
    }

    // decompiled from Move bytecode v6
}


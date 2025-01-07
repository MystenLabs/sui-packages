module 0x303a2f3eef0762dc1aee4cf7b350406460140f47b628ff672a31ea32a598be92::max {
    struct MAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAX>(arg0, 9, b"MAX", b"maxud78", b"maxud78 was created to make the world a better place", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba3f5bb7-c370-44b7-bd38-7ce669c9b7fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAX>>(v1);
    }

    // decompiled from Move bytecode v6
}


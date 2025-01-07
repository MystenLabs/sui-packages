module 0x33fc8872c800327a81f41d78282f42cd3e33786d48f82dbea84c6710cf83333c::bigcat {
    struct BIGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGCAT>(arg0, 9, b"BIGCAT", b"Catkute", b"Let the cute cat create value for you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98d915a0-7073-4c87-9948-32ef8be9f58c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


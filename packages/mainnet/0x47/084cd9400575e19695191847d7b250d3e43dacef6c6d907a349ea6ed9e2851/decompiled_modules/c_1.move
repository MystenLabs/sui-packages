module 0x47084cd9400575e19695191847d7b250d3e43dacef6c6d907a349ea6ed9e2851::c_1 {
    struct C_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: C_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C_1>(arg0, 9, b"C_1", b"Capybara", b"Capybara is a friendly animal, famous on all social networks, funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6e25050-9179-4dcd-b6bf-11e2b13d72a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<C_1>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x6e772f0b1601c6d110c499f52bf90c1624f3b208e180238ae43fc6015fda2810::capy {
    struct CAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPY>(arg0, 9, b"CAPY", b"Capybara", x"49e280996d206c69746572616c6c79206a75737420612063617079626172612e20466c79696e6720746f20746865206d6f6f6e20f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7266363-393b-4fbb-bc37-bacc49c1fd80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}


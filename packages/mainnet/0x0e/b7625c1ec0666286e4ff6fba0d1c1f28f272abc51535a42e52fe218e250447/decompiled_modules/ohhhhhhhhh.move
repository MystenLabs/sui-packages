module 0xeb7625c1ec0666286e4ff6fba0d1c1f28f272abc51535a42e52fe218e250447::ohhhhhhhhh {
    struct OHHHHHHHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: OHHHHHHHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OHHHHHHHHH>(arg0, 9, b"OHHHHHHHHH", b"lpllllllll", b"heyyyyyyyyyyyy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fefd8c24-1bfc-4eb7-8131-1283e3c3e808.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OHHHHHHHHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OHHHHHHHHH>>(v1);
    }

    // decompiled from Move bytecode v6
}


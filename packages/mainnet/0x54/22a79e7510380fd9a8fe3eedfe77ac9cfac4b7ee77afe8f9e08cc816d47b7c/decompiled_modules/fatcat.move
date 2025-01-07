module 0x5422a79e7510380fd9a8fe3eedfe77ac9cfac4b7ee77afe8f9e08cc816d47b7c::fatcat {
    struct FATCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATCAT>(arg0, 9, b"FATCAT", b"Fat Cat", b"The World Fattest Cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14300e4c-9dc0-4951-8057-3808f95961ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FATCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


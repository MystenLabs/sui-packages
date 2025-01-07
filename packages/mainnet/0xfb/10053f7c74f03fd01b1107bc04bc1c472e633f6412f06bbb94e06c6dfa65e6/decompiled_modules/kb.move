module 0xfb10053f7c74f03fd01b1107bc04bc1c472e633f6412f06bbb94e06c6dfa65e6::kb {
    struct KB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KB>(arg0, 9, b"KB", b"Kantong", b"Kantong Bird is a mascot of YouTube channel \"Kantong Bijak\" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18672caf-9041-423c-b995-537d8dc96cc8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KB>>(v1);
    }

    // decompiled from Move bytecode v6
}


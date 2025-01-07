module 0x65d0e49272d0b8d063e77cc0f907b4e0fe9d8edee9510a786ff23e114365c987::wacat {
    struct WACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WACAT>(arg0, 9, b"WACAT", b"WAWE", b"WAWE is a meme inspired by the sprit of adventure and freedom with WAWE. We are not just riding the waves- we are mastering them", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24f3fe78-6ce9-4309-8119-28ce60359436.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


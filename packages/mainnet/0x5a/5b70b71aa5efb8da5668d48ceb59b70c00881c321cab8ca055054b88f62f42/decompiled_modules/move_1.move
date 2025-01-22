module 0x5a5b70b71aa5efb8da5668d48ceb59b70c00881c321cab8ca055054b88f62f42::move_1 {
    struct MOVE_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVE_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVE_1>(arg0, 9, b"MOVE_1", b"Move", b"A Move token is a digital asset created and managed using the Move programming language, designed specifically for blockchain platforms like Sui and Aptos. Move tokens represent a unit of value and can serve various purposes, such as currency,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47dcf623-a24a-4484-a745-f85973fc7121.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVE_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVE_1>>(v1);
    }

    // decompiled from Move bytecode v6
}


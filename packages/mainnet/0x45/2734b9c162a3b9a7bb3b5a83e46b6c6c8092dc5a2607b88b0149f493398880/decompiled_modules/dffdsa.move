module 0x452734b9c162a3b9a7bb3b5a83e46b6c6c8092dc5a2607b88b0149f493398880::dffdsa {
    struct DFFDSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFFDSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFFDSA>(arg0, 9, b"DFFDSA", b"KJHHDF", b"BBCF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b87d9af5-a165-4546-9a98-e98887c543f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFFDSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFFDSA>>(v1);
    }

    // decompiled from Move bytecode v6
}


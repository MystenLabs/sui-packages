module 0xb7737a86c57729bff3a2ab52bf42b2dda2085177edcab76dd720968e75df85a9::waw {
    struct WAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAW>(arg0, 9, b"WAW", b"Wakanwaka", b"The new generation of Ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/375ac27a-591b-44c4-ac6b-7d89254bf809.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAW>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xb735515309f86cb38ed0e7b5cb17448d9660a7da9e542fb8ed6cd2c7bd49d0d5::sme {
    struct SME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SME>(arg0, 9, b"SME", b"Sam Meme", b"A Meme token for Sam and Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ee2da1c-a181-4f3c-96eb-f64d69d3c4a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SME>>(v1);
    }

    // decompiled from Move bytecode v6
}


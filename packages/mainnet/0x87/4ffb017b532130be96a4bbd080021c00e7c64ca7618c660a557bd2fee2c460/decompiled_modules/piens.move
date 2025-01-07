module 0x874ffb017b532130be96a4bbd080021c00e7c64ca7618c660a557bd2fee2c460::piens {
    struct PIENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIENS>(arg0, 9, b"PIENS", b"Suipiens", x"f09f9a80f09f92a7737472617020696e2c206772616220796f757220626f772c20616e64206a6f696e207468652053756970656e732041726d792061732077652061696d20666f7220646563656e7472616c697a656420676c6f7279f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0db6751-290f-4872-a58f-0026fcdc66fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIENS>>(v1);
    }

    // decompiled from Move bytecode v6
}


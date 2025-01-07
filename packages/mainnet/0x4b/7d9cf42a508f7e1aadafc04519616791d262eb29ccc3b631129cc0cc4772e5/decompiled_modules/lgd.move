module 0x4b7d9cf42a508f7e1aadafc04519616791d262eb29ccc3b631129cc0cc4772e5::lgd {
    struct LGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGD>(arg0, 9, b"LGD", b"Legends ", b"Legends, The Greatest Dogs Ever. Hold and Earn a LEGENDS NFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f83e972-b941-4c32-a807-dab3bc388507.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGD>>(v1);
    }

    // decompiled from Move bytecode v6
}


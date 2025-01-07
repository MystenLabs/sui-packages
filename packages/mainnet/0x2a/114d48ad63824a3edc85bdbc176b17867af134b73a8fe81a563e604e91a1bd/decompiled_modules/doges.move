module 0x2a114d48ad63824a3edc85bdbc176b17867af134b73a8fe81a563e604e91a1bd::doges {
    struct DOGES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGES>(arg0, 9, b"DOGES", b"DOGESUI", b"Hello world, DOGES is coming! Department of Government Efficiency. DOGES is meme coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bdfd4b68-2d6f-4bd0-a29d-2c7315b0ed47.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGES>>(v1);
    }

    // decompiled from Move bytecode v6
}


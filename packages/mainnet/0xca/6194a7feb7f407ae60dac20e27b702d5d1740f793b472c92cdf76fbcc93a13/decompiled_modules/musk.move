module 0xca6194a7feb7f407ae60dac20e27b702d5d1740f793b472c92cdf76fbcc93a13::musk {
    struct MUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSK>(arg0, 6, b"MUSK", b"SUI MUSK", b"SUI Musk aims to attract attention and potential investment by associating themselves with both the trending memecoin phenomenon and the influential tech entrepreneur.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suimusk_7f96c78122.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}


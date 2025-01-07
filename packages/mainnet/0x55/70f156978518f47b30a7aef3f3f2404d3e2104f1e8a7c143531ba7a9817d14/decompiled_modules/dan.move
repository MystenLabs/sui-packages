module 0x5570f156978518f47b30a7aef3f3f2404d3e2104f1e8a7c143531ba7a9817d14::dan {
    struct DAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAN>(arg0, 9, b"DAN", b"Danik", b"A lovely meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a001de5-03c9-4ad5-9241-da44d146a471.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAN>>(v1);
    }

    // decompiled from Move bytecode v6
}


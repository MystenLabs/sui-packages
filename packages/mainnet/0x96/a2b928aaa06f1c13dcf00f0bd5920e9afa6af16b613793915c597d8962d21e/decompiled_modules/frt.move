module 0x96a2b928aaa06f1c13dcf00f0bd5920e9afa6af16b613793915c597d8962d21e::frt {
    struct FRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRT>(arg0, 9, b"FRT", b"Frog", b"Just a frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6be63e31-558b-4b16-81ed-c88916a5024e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRT>>(v1);
    }

    // decompiled from Move bytecode v6
}


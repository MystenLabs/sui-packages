module 0xe07728fc1a7bc04be4938d897b98c979464af1a5d335441292649318dc1acda0::cl {
    struct CL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CL>(arg0, 9, b"CL", b"class", b"Class A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82a5bd58-b829-4e39-813b-bc51d3ac6735.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CL>>(v1);
    }

    // decompiled from Move bytecode v6
}


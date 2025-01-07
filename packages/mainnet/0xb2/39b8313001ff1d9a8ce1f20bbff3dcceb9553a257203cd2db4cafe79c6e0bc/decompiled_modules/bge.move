module 0xb239b8313001ff1d9a8ce1f20bbff3dcceb9553a257203cd2db4cafe79c6e0bc::bge {
    struct BGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGE>(arg0, 9, b"BGE", b"BAGGe", b"hy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/319cad56-fa47-4d25-9ddc-1ab67bc4a4fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BGE>>(v1);
    }

    // decompiled from Move bytecode v6
}


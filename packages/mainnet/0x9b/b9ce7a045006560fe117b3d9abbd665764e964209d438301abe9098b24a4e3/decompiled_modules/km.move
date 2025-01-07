module 0x9bb9ce7a045006560fe117b3d9abbd665764e964209d438301abe9098b24a4e3::km {
    struct KM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KM>(arg0, 9, b"KM", b"kapakmerah", b"Little community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ece89229-f7c5-4f84-9c4f-5c765783f2ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KM>>(v1);
    }

    // decompiled from Move bytecode v6
}


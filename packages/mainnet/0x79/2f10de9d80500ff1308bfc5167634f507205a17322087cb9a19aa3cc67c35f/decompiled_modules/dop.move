module 0x792f10de9d80500ff1308bfc5167634f507205a17322087cb9a19aa3cc67c35f::dop {
    struct DOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOP>(arg0, 9, b"DOP", b"DOLPHIN", b"Nope", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5d5bda9-3b6d-4c1b-8c9c-e6b84266c51b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOP>>(v1);
    }

    // decompiled from Move bytecode v6
}


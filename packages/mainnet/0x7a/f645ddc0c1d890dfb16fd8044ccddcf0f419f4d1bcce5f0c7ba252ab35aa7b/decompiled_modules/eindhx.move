module 0x7af645ddc0c1d890dfb16fd8044ccddcf0f419f4d1bcce5f0c7ba252ab35aa7b::eindhx {
    struct EINDHX has drop {
        dummy_field: bool,
    }

    fun init(arg0: EINDHX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EINDHX>(arg0, 9, b"EINDHX", b"hdisken", b"hsjsj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a1f4cb9-cc84-4a75-a9fd-e1458fe3e9f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EINDHX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EINDHX>>(v1);
    }

    // decompiled from Move bytecode v6
}


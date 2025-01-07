module 0x830c98ac5c240c45beea59f3437635ecfdbb18bf2fee1838223850d115374d0a::ont {
    struct ONT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONT>(arg0, 9, b"ONT", b"ONTARIO", b"Experience with us in the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e05de13-8538-4603-b070-8e1941527380.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONT>>(v1);
    }

    // decompiled from Move bytecode v6
}


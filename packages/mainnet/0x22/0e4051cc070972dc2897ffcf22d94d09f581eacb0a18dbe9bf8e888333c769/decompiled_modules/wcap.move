module 0x220e4051cc070972dc2897ffcf22d94d09f581eacb0a18dbe9bf8e888333c769::wcap {
    struct WCAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCAP>(arg0, 9, b"WCAP", b"Cap token", b" CAP Token is a digital currency designed for use within the Crypto Application (CAP) ecosystem. It facilitates various functions,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/37c0514a-f7b7-40d3-86e1-3ee13b0432c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCAP>>(v1);
    }

    // decompiled from Move bytecode v6
}


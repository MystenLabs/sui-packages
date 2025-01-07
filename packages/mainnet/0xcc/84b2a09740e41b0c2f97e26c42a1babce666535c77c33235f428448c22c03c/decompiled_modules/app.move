module 0xcc84b2a09740e41b0c2f97e26c42a1babce666535c77c33235f428448c22c03c::app {
    struct APP has drop {
        dummy_field: bool,
    }

    fun init(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APP>(arg0, 9, b"APP", b"APPLE", b"APPLE is a blue finance solution designed to support sustainable projects worldwide. By investing in eco-friendly initiatives, holders can contribute to a healthier planet while earning rewards tied to environmental impact and community growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1384213f-ffe1-48c1-9028-38317e487841.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APP>>(v1);
    }

    // decompiled from Move bytecode v6
}


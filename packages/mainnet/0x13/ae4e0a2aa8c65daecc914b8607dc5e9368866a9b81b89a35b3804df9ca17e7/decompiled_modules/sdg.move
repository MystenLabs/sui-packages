module 0x13ae4e0a2aa8c65daecc914b8607dc5e9368866a9b81b89a35b3804df9ca17e7::sdg {
    struct SDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDG>(arg0, 9, b"SDG", b"SH", b"FGH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce6501e7-0435-48e4-be76-6ffa69077ffa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDG>>(v1);
    }

    // decompiled from Move bytecode v6
}


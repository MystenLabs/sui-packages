module 0x550ce9ba731668a71d14ff41d904d08ef603b5b35bf6ad029cd5e95afb9d7209::ngt {
    struct NGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGT>(arg0, 9, b"NGT", b"SJP", b"Good morning I ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b2ee2bf-31d4-4486-babb-40fa01fa4dea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGT>>(v1);
    }

    // decompiled from Move bytecode v6
}


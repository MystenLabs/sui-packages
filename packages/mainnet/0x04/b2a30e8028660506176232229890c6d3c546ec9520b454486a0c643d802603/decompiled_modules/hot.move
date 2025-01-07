module 0x4b2a30e8028660506176232229890c6d3c546ec9520b454486a0c643d802603::hot {
    struct HOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOT>(arg0, 9, b"HOT", b"Hot", b"The Hot protocol token will serve as the connecting element of the entire ecosystem in DeFi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/544e9715-a6cb-4e5f-a6d9-cb0a4096ec3f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOT>>(v1);
    }

    // decompiled from Move bytecode v6
}


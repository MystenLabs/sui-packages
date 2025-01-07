module 0x19f848d5041623a56a8b6aba15bc0fc9376b4b564f1f02f5b72f1235ccc162d3::g_999g {
    struct G_999G has drop {
        dummy_field: bool,
    }

    fun init(arg0: G_999G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G_999G>(arg0, 9, b"G_999G", b"gaugaugau", b"gaugau to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f55ef67-2874-46dc-bc04-8cc964454102.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G_999G>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<G_999G>>(v1);
    }

    // decompiled from Move bytecode v6
}


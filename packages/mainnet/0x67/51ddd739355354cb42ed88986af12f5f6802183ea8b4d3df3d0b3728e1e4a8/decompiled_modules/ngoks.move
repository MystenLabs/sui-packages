module 0x6751ddd739355354cb42ed88986af12f5f6802183ea8b4d3df3d0b3728e1e4a8::ngoks {
    struct NGOKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGOKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGOKS>(arg0, 9, b"NGOKS", b"NGOK", b"EHEEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e1bd249-6ec7-4ae8-96ce-6d0a8c2569a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGOKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGOKS>>(v1);
    }

    // decompiled from Move bytecode v6
}


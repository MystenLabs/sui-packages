module 0xf1ffee12ac23433accb4120c286e42d4eb7885639074ba444a325542348ed21e::hgjfgh {
    struct HGJFGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HGJFGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HGJFGH>(arg0, 9, b"HGJFGH", b"ASDASD", b"SDFGSF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5af69117-08ed-4ce9-93e2-625c2db61df2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HGJFGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HGJFGH>>(v1);
    }

    // decompiled from Move bytecode v6
}


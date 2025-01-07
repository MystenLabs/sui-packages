module 0x68885509f0fbcb68a8030521ed6a3f4b4af07abf1098fe683589a543ac7f006f::ivfun {
    struct IVFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVFUN>(arg0, 9, b"IVFUN", b"Invest Zon", b"Just for fun and grab some", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a68a9bc7-7755-424e-9658-99f0e3a2272e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IVFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}


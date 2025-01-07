module 0x67606ed486977401d582330aed2e3eb50f958fa9185194fab13782494db7339d::a3p {
    struct A3P has drop {
        dummy_field: bool,
    }

    fun init(arg0: A3P, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A3P>(arg0, 9, b"A3P", b"Zuckerberg", b"Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80f65937-54de-4207-af08-72af0e429b60.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A3P>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A3P>>(v1);
    }

    // decompiled from Move bytecode v6
}


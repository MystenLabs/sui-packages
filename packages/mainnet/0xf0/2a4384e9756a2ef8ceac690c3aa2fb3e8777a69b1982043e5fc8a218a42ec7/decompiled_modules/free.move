module 0xf02a4384e9756a2ef8ceac690c3aa2fb3e8777a69b1982043e5fc8a218a42ec7::free {
    struct FREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREE>(arg0, 9, b"FREE", b"FREE Token", b"Free Token for Sniping Demo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40eb7b99-b61e-476d-ab13-bbedf0545d5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FREE>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xd5cc5cc0cdf09c70ffe7b0df4a7ce35d1180b63e9ab354c3b700b58dfb7c7603::doubleg {
    struct DOUBLEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUBLEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUBLEG>(arg0, 9, b"DOUBLEG", b"GG", b"New era has begun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61bc7a93-5438-4333-82ba-6ea9b02c48f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUBLEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOUBLEG>>(v1);
    }

    // decompiled from Move bytecode v6
}


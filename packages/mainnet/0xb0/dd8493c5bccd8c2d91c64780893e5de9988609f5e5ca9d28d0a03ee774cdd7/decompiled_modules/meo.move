module 0xb0dd8493c5bccd8c2d91c64780893e5de9988609f5e5ca9d28d0a03ee774cdd7::meo {
    struct MEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEO>(arg0, 9, b"MEO", b"Meo", b"a cat ready to prey on a greedy mouse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac05da3a-9e9f-441f-9ba8-a1d4a6ebfb36.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEO>>(v1);
    }

    // decompiled from Move bytecode v6
}


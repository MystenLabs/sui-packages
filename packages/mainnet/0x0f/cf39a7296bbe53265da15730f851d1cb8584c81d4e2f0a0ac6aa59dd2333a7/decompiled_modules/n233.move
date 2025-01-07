module 0xfcf39a7296bbe53265da15730f851d1cb8584c81d4e2f0a0ac6aa59dd2333a7::n233 {
    struct N233 has drop {
        dummy_field: bool,
    }

    fun init(arg0: N233, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<N233>(arg0, 9, b"N233", b"GuGu", b"Devil fruit has the ability to help the eater fly 1m above the ground.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/836c6c6e-1e38-43a9-9110-260b4f2af44b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<N233>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<N233>>(v1);
    }

    // decompiled from Move bytecode v6
}


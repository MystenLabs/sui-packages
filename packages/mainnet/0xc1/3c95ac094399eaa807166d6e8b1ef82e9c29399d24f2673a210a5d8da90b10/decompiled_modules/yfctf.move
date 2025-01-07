module 0xc13c95ac094399eaa807166d6e8b1ef82e9c29399d24f2673a210a5d8da90b10::yfctf {
    struct YFCTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: YFCTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YFCTF>(arg0, 9, b"YFCTF", b"Gvhfy", b"Tcftf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee88818c-d082-4afb-913c-7d5985a1e409.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YFCTF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YFCTF>>(v1);
    }

    // decompiled from Move bytecode v6
}


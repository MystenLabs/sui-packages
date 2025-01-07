module 0x7f93b7417dd73439435428c39e968ae8a5643c810f10b307edd1036b3c5dc595::lw {
    struct LW has drop {
        dummy_field: bool,
    }

    fun init(arg0: LW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LW>(arg0, 9, b"LW", b"LOVEWORL", b"symbol of peace, protesting against war and connecting people around the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a16b9634-85d8-4915-b8a8-9fa3811441f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LW>>(v1);
    }

    // decompiled from Move bytecode v6
}


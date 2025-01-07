module 0x357d7dd6629da8713396d212f9cb71fcac1bc07929b61413c2e159e366b5daea::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 9, b"WHALE", x"4361707461696e20f09f90b3", x"4361707461696e20f09f90b320284361707461696e205768616c652920697320746865206c6567656e64617279206c6561646572206f662074686520646565702c2072756c696e67206f76657220746865206f6365616e207769746820776973646f6d20616e6420737472656e6774682e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74e66c3f-1aeb-4244-bd78-832f8baadd6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}


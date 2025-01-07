module 0x8ed469a5e36b5469203425639b99afb325d5ede69bad43287200738c0689664d::ttm {
    struct TTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTM>(arg0, 9, b"TTM", b"TOTHEMOON", x"546f20746865206d6f6f6ef09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/92eede92-582d-4942-ac29-03f5a8160ef1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTM>>(v1);
    }

    // decompiled from Move bytecode v6
}


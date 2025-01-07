module 0x89a3eb275bf93ccee15fa48ec0f987438f808d2a3f7db56819ceb33a24dd43ee::lpt {
    struct LPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPT>(arg0, 9, b"LPT", b"Little Pig", b"Think about meme and rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58d0ff14-2ff3-40a6-8589-a36b19d98f17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPT>>(v1);
    }

    // decompiled from Move bytecode v6
}


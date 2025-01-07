module 0xb2155264f33177877767641c189944f4c7fe0f34bccac867a865410e369f1b11::txc {
    struct TXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TXC>(arg0, 9, b"TXC", b"TOXIC", b"toxic coin , toxic meme , toxic market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d3279cd-4f17-48a7-bde6-7f5fabb67e64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TXC>>(v1);
    }

    // decompiled from Move bytecode v6
}


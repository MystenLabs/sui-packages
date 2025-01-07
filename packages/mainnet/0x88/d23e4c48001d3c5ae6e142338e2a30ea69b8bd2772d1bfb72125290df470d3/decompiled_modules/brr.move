module 0x88d23e4c48001d3c5ae6e142338e2a30ea69b8bd2772d1bfb72125290df470d3::brr {
    struct BRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRR>(arg0, 9, b"BRR", b"boar", b"Good meat to buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb67eb84-658b-4137-8151-c2353dc72624.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRR>>(v1);
    }

    // decompiled from Move bytecode v6
}


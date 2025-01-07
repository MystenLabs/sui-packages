module 0xa21eed2333a6f4ea48a359b051c515957a418a3df84bc2af51b8f220db612d14::mosquito {
    struct MOSQUITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSQUITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSQUITO>(arg0, 9, b"MOSQUITO", b"msq", b"Mosquito is an organized meme coin that will be the meme coin of the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ceb3a824-5af8-4715-a5fd-9610f466d407.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSQUITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOSQUITO>>(v1);
    }

    // decompiled from Move bytecode v6
}


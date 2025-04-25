module 0xf4a2106a5bdb556455faa40999f4e92ea13d1b1820386dd9327a1d5b36c2b9f2::lofi {
    struct LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFI>(arg0, 6, b"LOFI", b"LoFI", b"Born again in the 21st century, Lofi embodies optimism, courage, and vision for a better tomorrow. Lofi is not just an avatar for a new dawn in finance, but a movement. Lofi represents a collective mission to build a thriving, forward-thinking ecosystem on the Sui blockchain. Together, we are Lofi. Together, we are building the future. The future of decentralized finance is brightbuild it with us.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mmexport1745564108425_808eed72f7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}


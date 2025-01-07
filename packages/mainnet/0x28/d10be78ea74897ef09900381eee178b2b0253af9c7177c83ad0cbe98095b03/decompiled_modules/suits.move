module 0x28d10be78ea74897ef09900381eee178b2b0253af9c7177c83ad0cbe98095b03::suits {
    struct SUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITS>(arg0, 6, b"SUITS", b"SUITS SUI", b"LET'S FCKING GO WITH SUITS . BEST MEME ON SUI WILL TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xe56f87cd84820b89d292523a0191c732a3e48f8520a13e886393799df31f9de3_suits_suits_55bcde21d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITS>>(v1);
    }

    // decompiled from Move bytecode v6
}


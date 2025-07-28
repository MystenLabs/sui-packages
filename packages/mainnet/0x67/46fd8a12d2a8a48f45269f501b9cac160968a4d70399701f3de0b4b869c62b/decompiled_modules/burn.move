module 0x6746fd8a12d2a8a48f45269f501b9cac160968a4d70399701f3de0b4b869c62b::burn {
    struct BURN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURN>(arg0, 6, b"BURN", b"BurnPlay", b"BurnPlay ($BURN) is a game-based deflationary token on SUI, offering weekly rewards and extra prizes, like the Year-end jackpot! The Ultimate Crypto Gaming Experience! Play addictive games, burn tokens, earn rewards on the SUI blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000120973_3e1f8740f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURN>>(v1);
    }

    // decompiled from Move bytecode v6
}


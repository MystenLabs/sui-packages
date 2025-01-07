module 0x252696a18181d79d404b9c4dfb4565973b3dad41939ed29f5dff15f54fcfe6a::ddoge2014 {
    struct DDOGE2014 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDOGE2014, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDOGE2014>(arg0, 6, b"Ddoge2014", b"Doge2014", b"Doge2014:Doge2014 is a crypto project celebrating the 10th anniversary of Dogecoin, offering tokens at the nostalgic 2014 Dogecoin price and providing opportunities for staking and community rewards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/neira_e41387d09a.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDOGE2014>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDOGE2014>>(v1);
    }

    // decompiled from Move bytecode v6
}


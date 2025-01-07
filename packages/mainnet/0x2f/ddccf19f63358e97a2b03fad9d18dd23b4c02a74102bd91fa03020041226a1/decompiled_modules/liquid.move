module 0x2fddccf19f63358e97a2b03fad9d18dd23b4c02a74102bd91fa03020041226a1::liquid {
    struct LIQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQUID>(arg0, 6, b"LIQUID", b"LIQUIDITY", b"The Liquidity token on the SUI network is designed to support trading volume on SUI by developing a community of individuals that together, promote the network effect on SUI by increasing the number of participants that buy, sell and trade on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LIQUIDITY_dddc9ce637_5c88909656.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}


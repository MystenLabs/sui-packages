module 0xe41332592192cf56fce36f9a6ea0a63238f5155aea1367c27785587da805ae::just {
    struct JUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUST>(arg0, 6, b"Just", b"Just Trade", b"Just Trade is a cryptocurrency with a straightforward and uncomplicated purpose: to facilitate trading. Created exclusively for those who want to buy and sell with speed and efficiency, Just Trade is designed to serve traders of all levels, offering liquidity and quick transactions. Without complex functions or secondary features, this cryptocurrency focuses solely on the essentials, allowing investors to maximize their trading experience without distractions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_039a969e52.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUST>>(v1);
    }

    // decompiled from Move bytecode v6
}


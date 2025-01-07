module 0xc3c2d5e303b64e61851a145c0dd30a1290ea7402023f505661ca96d1becaf88b::sponge {
    struct SPONGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGE>(arg0, 6, b"Sponge", b"Sponge on Sui", x"496e206120776f726c642066696c6c65642077697468207368696e7920636f696e7320616e64206f7665722d7468652d746f702070726f6d697365732c20612074697265642073706f6e676520656d657267656468616c662061736c6565702c2066756c6c792068696c6172696f75732e204974206469646e74206361726520666f72207574696c697479206f7220636f6d706c6578206d656368616e6963732e204974206f6e6c79206b6e6577206f6e65207468696e673a0a576879207374726573733f204a757374206162736f726220746865206d656d65732e0a53756920616d626173737361646f722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_15_at_21_01_29_7d33da6078.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONGE>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x73e5babfbb4957c95e6e6f64f0e6a1be72c60f74d3c4e8e3fcccd4d5acc64503::rugpull {
    struct RUGPULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGPULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGPULL>(arg0, 9, b"RUGPULL", b"Captain Rug Pull", x"4361707461696e205275672050756c6c20436f696e3a2054686520756c74696d61746520646567656e2062616467652c20776f726e20627920746865206b696e67206f662063727970746f207363616d732e2043726f776e6564206d6173746572206f66207275672070756c6c732c206c656176696e6720777265636b65642077616c6c65747320696e206869732077616b652e20486f6c6420696620796f7520646172652120f09f98882023527567676564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/3qBxVGRRmbyqiDzgH937nu2rtiUkP2JAnnyehF9Npump.png?size=lg&key=d2b6c0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUGPULL>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGPULL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGPULL>>(v1);
    }

    // decompiled from Move bytecode v6
}


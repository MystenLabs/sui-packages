module 0xeed6b613e4724d2b91b96f4bcaa421766387425f72420765003436d225bb14bb::coinmaster {
    struct COINMASTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINMASTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINMASTER>(arg0, 6, b"COINMASTER", b"Coin Master On Sui", b"You re not just a Holder you re a Master", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifo7b4c33eapywv43knths724w2gxea2gad6pog2kzi4icmdxvut4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINMASTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COINMASTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


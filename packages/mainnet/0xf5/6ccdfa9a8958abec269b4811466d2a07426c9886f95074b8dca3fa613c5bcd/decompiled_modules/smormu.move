module 0xf56ccdfa9a8958abec269b4811466d2a07426c9886f95074b8dca3fa613c5bcd::smormu {
    struct SMORMU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SMORMU>, arg1: 0x2::coin::Coin<SMORMU>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SMORMU>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SMORMU>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SMORMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMORMU>(arg0, 6, b"SMORMU SHRIM KING ", b"SMORMU", b"Meet $SMORMU, the newest star in the meme token galaxy! Smormu is a character from Smiling Friends. https://www.smormu.fun/  https://x.com/smormusui https://t.me/smormuportal ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-magnetic-ptarmigan-262.mypinata.cloud/ipfs/QmNiPGC7qmWx9FGM34yNDZ7LVdhJVAPAX3xdebk9nKGvBe")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMORMU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMORMU>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SMORMU>, arg1: 0x2::coin::Coin<SMORMU>) : u64 {
        0x2::coin::burn<SMORMU>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SMORMU>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SMORMU> {
        0x2::coin::mint<SMORMU>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}


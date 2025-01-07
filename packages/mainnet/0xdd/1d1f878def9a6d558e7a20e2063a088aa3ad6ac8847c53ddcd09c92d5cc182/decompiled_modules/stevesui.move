module 0xdd1d1f878def9a6d558e7a20e2063a088aa3ad6ac8847c53ddcd09c92d5cc182::stevesui {
    struct STEVESUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<STEVESUI>, arg1: 0x2::coin::Coin<STEVESUI>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STEVESUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STEVESUI>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: STEVESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEVESUI>(arg0, 6, b"STEVE", b"SteveSui", b"$STEVE Memecoin is a fun, meme-inspired cryptocurrency designed to bring the community together through humor, creativity, and viral meme culture   https://x.com/stevesuicoin   https://t.me/stevesui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmUsWS9vv4239ZxaLjgP6YkZiq4Muk2HcZ3yej4GssgV8M")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STEVESUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEVESUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<STEVESUI>, arg1: 0x2::coin::Coin<STEVESUI>) : u64 {
        0x2::coin::burn<STEVESUI>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<STEVESUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<STEVESUI> {
        0x2::coin::mint<STEVESUI>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}


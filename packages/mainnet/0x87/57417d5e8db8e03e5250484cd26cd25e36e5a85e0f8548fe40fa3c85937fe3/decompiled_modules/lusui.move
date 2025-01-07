module 0x8757417d5e8db8e03e5250484cd26cd25e36e5a85e0f8548fe40fa3c85937fe3::lusui {
    struct LUSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LUSUI>, arg1: 0x2::coin::Coin<LUSUI>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LUSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LUSUI>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: LUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUSUI>(arg0, 6, b"LUSUI", b"Lusui", b"cute lil cool, chilling in a very warm place.   https://x.com/lusuiofficial   https://t.me/lusuiportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmTGjRUpz4vW5NYR6aaiGsaqWsE14LwowHeKV1xNv6F7Fg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<LUSUI>, arg1: 0x2::coin::Coin<LUSUI>) : u64 {
        0x2::coin::burn<LUSUI>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<LUSUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LUSUI> {
        0x2::coin::mint<LUSUI>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}


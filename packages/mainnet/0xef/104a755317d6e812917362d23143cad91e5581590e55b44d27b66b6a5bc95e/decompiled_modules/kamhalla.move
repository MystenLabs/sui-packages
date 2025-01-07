module 0xef104a755317d6e812917362d23143cad91e5581590e55b44d27b66b6a5bc95e::kamhalla {
    struct KAMHALLA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KAMHALLA>, arg1: 0x2::coin::Coin<KAMHALLA>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KAMHALLA>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KAMHALLA>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: KAMHALLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMHALLA>(arg0, 6, b"KAMHALLA HARRIS", b"KAMHALLA", b"Embodying the fierce spirit of a Viking Warrior, $KAMHALLA confronts Biden seeking to carve a new path unburdened by the past.? https://x.com/kamhaala_harris https://kamhaala.vip/ https://t.me/kamhalla  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-magnetic-ptarmigan-262.mypinata.cloud/ipfs/QmU5xSKDdfEC8n7zyCL4Z7NefKVNhZAaQ5WuKyFgTmwpJf")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMHALLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMHALLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<KAMHALLA>, arg1: 0x2::coin::Coin<KAMHALLA>) : u64 {
        0x2::coin::burn<KAMHALLA>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<KAMHALLA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<KAMHALLA> {
        0x2::coin::mint<KAMHALLA>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}


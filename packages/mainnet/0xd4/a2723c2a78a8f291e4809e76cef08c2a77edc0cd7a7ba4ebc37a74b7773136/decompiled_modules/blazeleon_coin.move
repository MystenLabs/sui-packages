module 0xd4a2723c2a78a8f291e4809e76cef08c2a77edc0cd7a7ba4ebc37a74b7773136::blazeleon_coin {
    struct BLAZELEON_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BLAZELEON_COIN>, arg1: 0x2::coin::Coin<BLAZELEON_COIN>) {
        0x2::coin::burn<BLAZELEON_COIN>(arg0, arg1);
    }

    fun init(arg0: BLAZELEON_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAZELEON_COIN>(arg0, 9, b"BLAZELEON_COIN", b"blazeleon_coin", b"Let's make SUI great again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/48305889?v=4")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BLAZELEON_COIN>>(0x2::coin::mint<BLAZELEON_COIN>(&mut v2, 21000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLAZELEON_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAZELEON_COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<BLAZELEON_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BLAZELEON_COIN>>(0x2::coin::mint<BLAZELEON_COIN>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}


module 0xc051775ba30bc1ef75f09fd36a118f7d098ff65ad53f9269fe2d9c173bab6066::SUIGOAT {
    struct SUIGOAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIGOAT>, arg1: 0x2::coin::Coin<SUIGOAT>) {
        0x2::coin::burn<SUIGOAT>(arg0, arg1);
    }

    fun init(arg0: SUIGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOAT>(arg0, 6, b"suiGOAT", b"Sui Goat", b"Twitter: @SUIGOAT, Telegram: t.me/SUIGOAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/9069.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGOAT>>(v1);
        0x2::coin::mint_and_transfer<SUIGOAT>(&mut v2, 250000000000000, 0x2::address::from_u256(12645683887451905395910008806803983941693237173785018593378697182617085828444), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIGOAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIGOAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


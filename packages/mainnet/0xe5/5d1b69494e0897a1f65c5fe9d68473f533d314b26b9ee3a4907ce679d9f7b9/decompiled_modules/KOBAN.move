module 0xe55d1b69494e0897a1f65c5fe9d68473f533d314b26b9ee3a4907ce679d9f7b9::KOBAN {
    struct KOBAN has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<KOBAN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0xefb0916f3e2f3823134ccfc438e108aa142f6e78b2e587eedc6affdd6c13879c || 0x2::tx_context::sender(arg2) == @0xefb0916f3e2f3823134ccfc438e108aa142f6e78b2e587eedc6affdd6c13879c, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<KOBAN>>(arg0, arg1);
    }

    fun init(arg0: KOBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBAN>(arg0, 9, b"KOBAN", b"Lucky Kat", b"$KOBAN is a utility token empowering an ecosystem of games on our upcoming Takibi Protocol. It serves as a premium in-game currency, offering various utilities and cross-compatibility across titles from Lucky Kat Studios, Fragbite Group, and other third-party developers. $KOBAN is designed for cross-game use, allowing players to seamlessly use and transfer it between different titles, creating a gaming environment that gives power to players, leveraging their $KOBAN across an interconnected ecosystem of games.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://tan-hidden-shark-534.mypinata.cloud/ipfs/bafybeigbvvy3sg666337wocwqz4apm7g4aoey5flsfuweeciplmaunwdry")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<KOBAN>>(0x2::coin::mint<KOBAN>(&mut v2, 1000000000000000000, arg1), @0xefb0916f3e2f3823134ccfc438e108aa142f6e78b2e587eedc6affdd6c13879c);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KOBAN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOBAN>>(v1);
    }

    // decompiled from Move bytecode v6
}


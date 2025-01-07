module 0xd6aebec2fb57251ab1f2e038b8896fb920db6122a9f7d812ad748a16f7be2649::doggo {
    struct DOGGO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGGO>, arg1: 0x2::coin::Coin<DOGGO>) {
        0x2::coin::burn<DOGGO>(arg0, arg1);
    }

    fun init(arg0: DOGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGO>(arg0, 9, b"DOGGO", b"DOGGO DOGGO", b"DOGGO DOGGO DOGGO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRH1Vhx8ZUB7b8MRjg42L81kJ1LZ3AWWKV6tnb9rqC3Xn")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGGO>(&mut v2, 25000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGO>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGGO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGGO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


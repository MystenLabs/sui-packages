module 0x7140332bc22590ee6b080dd9f0d9c2605702342730f1feea89924e3ac393f7cd::igw {
    struct IGW has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<IGW>, arg1: 0x2::coin::Coin<IGW>) {
        0x2::coin::burn<IGW>(arg0, arg1);
    }

    fun init(arg0: IGW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGW>(arg0, 9, b"Internet Generational Wealth", b"IGW", b"Internet Generational Wealth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWixqoPHm6qPW7nqhw1B2ccZ9QxCpLsNhjqqiGhy2WLRT")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IGW>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IGW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGW>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<IGW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<IGW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


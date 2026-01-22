module 0xa93629860a9cfa795ddbc27a22488e494d51a9161c9288d3aa85ae72feebb135::poors {
    struct POORS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<POORS>, arg1: 0x2::coin::Coin<POORS>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<POORS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<POORS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<POORS>>(0x2::coin::mint<POORS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: POORS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POORS>(arg0, 9, b"POORS", b"POOR SUI", b"One dollar for every human on earth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieluhyaiq3e2lxfuvj7oz4uh7baz2crw6wnfwcfzk7jfqke7sgepu?filename=POORS.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POORS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POORS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


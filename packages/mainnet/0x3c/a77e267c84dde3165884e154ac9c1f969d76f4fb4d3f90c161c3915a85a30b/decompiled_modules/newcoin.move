module 0x3ca77e267c84dde3165884e154ac9c1f969d76f4fb4d3f90c161c3915a85a30b::newcoin {
    struct NEWCOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<NEWCOIN>, arg1: 0x2::coin::Coin<NEWCOIN>) {
        0x2::coin::burn<NEWCOIN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEWCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NEWCOIN>>(0x2::coin::mint<NEWCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NEWCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWCOIN>(arg0, 9, b"USDT", b"Tatr USD", b"yulezhuanyong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uploader.irys.xyz/HiZKj8fYVf5VvDTywJQNMCLKSjAku7i2mq2innSLz5M7")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<NEWCOIN>>(0x2::coin::mint<NEWCOIN>(&mut v2, 1000000000000, arg1), @0x5241f18a5fbb1cf10253bb1615d129db659c5152a2943a901dde030e18591c62);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWCOIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun public_burn(arg0: &mut 0x2::coin::TreasuryCap<NEWCOIN>, arg1: 0x2::coin::Coin<NEWCOIN>) {
        burn(arg0, arg1);
    }

    public entry fun public_mint(arg0: &mut 0x2::coin::TreasuryCap<NEWCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        mint(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


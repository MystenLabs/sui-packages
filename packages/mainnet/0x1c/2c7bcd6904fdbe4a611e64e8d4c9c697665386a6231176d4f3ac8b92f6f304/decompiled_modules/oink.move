module 0x1c2c7bcd6904fdbe4a611e64e8d4c9c697665386a6231176d4f3ac8b92f6f304::oink {
    struct OINK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OINK>, arg1: 0x2::coin::Coin<OINK>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<OINK>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OINK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<OINK>>(0x2::coin::mint<OINK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: OINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OINK>(arg0, 9, b"OINK", b"OINK", b"Sui pigs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid3f5tyejrdvaarc6s5y33elmxckhqesadstsi3oelr5pn5cqbso4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OINK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x888928248b9060b9d6b16a6ff3528704769b8195209ec22a6cf291534a9c7f58::cyb168 {
    struct CYB168 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CYB168>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CYB168>>(0x2::coin::mint<CYB168>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CYB168, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYB168>(arg0, 9, b"CYB168", b"CYBER AI", x"437962657220414920746f6b656e20e28094204669626f6e6163636920737570706c793a203233332e20496e737572616e63653a203130306270732e2058616861753a20727063677a7456693147436d773563776f55474565374871365831783156466b6452", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zedec.io/tokens/cyb168.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYB168>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYB168>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


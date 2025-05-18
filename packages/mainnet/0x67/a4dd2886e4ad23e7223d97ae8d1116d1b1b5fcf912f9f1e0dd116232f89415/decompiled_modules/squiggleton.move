module 0x67a4dd2886e4ad23e7223d97ae8d1116d1b1b5fcf912f9f1e0dd116232f89415::squiggleton {
    struct SQUIGGLETON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIGGLETON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIGGLETON>(arg0, 9, b"SQUIG", b"Squiggleton", x"54686520636861727420676f65732075702c20646f776e2c207369646577617973e280a6206974277320616c6c207371756967676c657320746f205371756967676c65746f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie2wfdsjv6rfjs5pef3exzzqdnevsmcjaaakq27vsegpa5svqdeha")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SQUIGGLETON>(&mut v2, 1000000000000000000, @0x72c767ff9daadbf73e24475876ba497a7bc211f59e49cc673f495dd24420383b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIGGLETON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIGGLETON>>(v1);
    }

    // decompiled from Move bytecode v6
}


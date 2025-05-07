module 0xb4b100a8e299e89629607001de8fd8ee85b87bc88cbadd47ca761fbee6da4516::squiggleton {
    struct SQUIGGLETON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIGGLETON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIGGLETON>(arg0, 9, b"SQUIG", b"Squiggleton", x"54686520636861727420676f65732075702c20646f776e2c207369646577617973e280a6206974277320616c6c207371756967676c657320746f205371756967676c65746f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie2wfdsjv6rfjs5pef3exzzqdnevsmcjaaakq27vsegpa5svqdeha")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SQUIGGLETON>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIGGLETON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIGGLETON>>(v1);
    }

    // decompiled from Move bytecode v6
}


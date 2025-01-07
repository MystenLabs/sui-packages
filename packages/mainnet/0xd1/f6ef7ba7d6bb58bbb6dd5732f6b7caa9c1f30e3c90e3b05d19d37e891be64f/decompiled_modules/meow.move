module 0xd1f6ef7ba7d6bb58bbb6dd5732f6b7caa9c1f30e3c90e3b05d19d37e891be64f::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 9, b"MEOW", b"Mew Mew", b"MEOW MEOW MEOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/QmZdVZMmyCfaCXgEWcJ3jsWRzxFWdN38qYUSHxHuoxzJi2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEOW>(&mut v2, 409788000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x56572fe6be26e39299322818d366b98eb4f63dd8c88c1f81c54e0291cd659a0a::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 9, b"MEOW", b"Meow", x"244d454f5720696e737069726564206279204d617474204675726965e28099732069636f6e696320617274776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmZiLvixwd9AytJjEu7sXjGT8hvTRjePQrhiqQ6rSvsHM4?img-width=800&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEOW>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xd3a7d7be9c09e743de583c698acdaa76aa536071f2c8a772d1f0f99b29eb9b0c::fizzbug {
    struct FIZZBUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIZZBUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIZZBUG>(arg0, 9, b"FIZZ", b"Fizzbug", x"48797065722c207a697070792c20616e64206a7573742061206c6974746c6520626974206368616f746963e2809446697a7a627567206a756d70732066726f6d2070756d7020746f2070756d7020616e64206c656176657320737061726b6c657320696e206974732077616b6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihaaill5tfr2nzi5kwtax6mrfk4iqv7ivyoybauygg2ud3ay44que")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FIZZBUG>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIZZBUG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIZZBUG>>(v1);
    }

    // decompiled from Move bytecode v6
}


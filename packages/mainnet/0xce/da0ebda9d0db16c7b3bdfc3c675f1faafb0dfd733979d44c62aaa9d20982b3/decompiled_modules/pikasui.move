module 0xceda0ebda9d0db16c7b3bdfc3c675f1faafb0dfd733979d44c62aaa9d20982b3::pikasui {
    struct PIKASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKASUI>(arg0, 9, b"PIKASUI", b"PikaSUI", b"Electric mouse-inspired token on the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaoci3gcdsr54ppkhekkkc7zxwpx4r7n4zrlca5ukjuop572b2ofa")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIKASUI>(&mut v2, 1000000000000000000, @0xae42d2ec4d8ad9708972e523c8aad72bdd89ee7df04afc8a221545ac9577763c, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKASUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


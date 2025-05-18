module 0xbb95f5ce8abbcd663e4e9f47e30b3136335a0c22d2c6d35f9b44df4dbe51ba6f::pikasui {
    struct PIKASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKASUI>(arg0, 9, b"PIKASUI", b"PikaSUI", b"Electric mouse-inspired token on the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaoci3gcdsr54ppkhekkkc7zxwpx4r7n4zrlca5ukjuop572b2ofa")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIKASUI>(&mut v2, 1000000000000000000, @0x86d23a68cdddbdb748c8d40aa226afed8e5f87c5d5dc8e904c13971759339c73, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKASUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


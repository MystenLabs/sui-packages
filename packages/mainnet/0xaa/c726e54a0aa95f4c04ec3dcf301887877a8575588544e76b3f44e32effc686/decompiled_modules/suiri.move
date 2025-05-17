module 0xaac726e54a0aa95f4c04ec3dcf301887877a8575588544e76b3f44e32effc686::suiri {
    struct SUIRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRI>(arg0, 6, b"SUIRI", b"SuiriOnSui", b"Suiri On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigg4f3jia7bkeok5xwntmj2jftbxdpn24ojt43jktw5xebtsap4hm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIRI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


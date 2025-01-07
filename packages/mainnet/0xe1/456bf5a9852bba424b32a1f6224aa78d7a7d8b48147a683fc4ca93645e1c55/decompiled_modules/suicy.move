module 0xe1456bf5a9852bba424b32a1f6224aa78d7a7d8b48147a683fc4ca93645e1c55::suicy {
    struct SUICY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICY>(arg0, 9, b"SUICY", b"SUICY", b"SUICY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmYeve6vnXnNWrhwLBKkugb1hDJNjkpP2tj64Y2HWJeKSf")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}


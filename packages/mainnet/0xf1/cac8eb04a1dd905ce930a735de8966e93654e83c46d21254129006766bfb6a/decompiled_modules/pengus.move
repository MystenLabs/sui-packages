module 0xf1cac8eb04a1dd905ce930a735de8966e93654e83c46d21254129006766bfb6a::pengus {
    struct PENGUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUS>(arg0, 6, b"Pengus", b"PENGUSWIFE", b"Pengus is polly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibuhl5kwdzdcj3rrvn7wnanzza2xtd5w3dxnzp7lhfyziejgjxtri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PENGUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


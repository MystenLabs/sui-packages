module 0x4e7dce7ed5d6a5d9e7c51dec2f934f33aba06c82e7bbd8c2598ac625ba9e3c51::su {
    struct SU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SU>(arg0, 9, b"SU|", b"Sui", b"Native token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdLkKvL7UyS9r9pFqb2kUpCBoYn861HQt51Bs21fkHxq5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SU>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SU>>(v1);
    }

    // decompiled from Move bytecode v6
}


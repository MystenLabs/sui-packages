module 0x978454d907d6179e089a5c5c5ac9755adc42f136186ef55ef2b45357e831181::usdd {
    struct USDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDD>(arg0, 9, b"USDD", b"USDD", b"The USDD protocol aims to provide the blockchain industry with the most stable, decentralized, tamper-proof, and freeze-free stablecoin system, a perpetual system independent from any centralized entity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/2c1ZlZgV4gRWXiOpPAjONRUT8QZ3frJMHZTUwJEwCj8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDD>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDD>>(v2, @0xb7288f67f831456aa1eaa7d79414bebdb7d6a355ba5f15040f3a6e2a03d422fe);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDD>>(v1);
    }

    // decompiled from Move bytecode v6
}


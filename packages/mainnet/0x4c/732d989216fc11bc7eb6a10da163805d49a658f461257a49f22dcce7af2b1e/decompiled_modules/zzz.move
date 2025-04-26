module 0x4c732d989216fc11bc7eb6a10da163805d49a658f461257a49f22dcce7af2b1e::zzz {
    struct ZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZZ>(arg0, 6, b"YYY", b"YYY on Sui", b"YYY on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZZZ>>(v1);
        0x2::coin::mint_and_transfer<ZZZ>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZ>>(v2, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZZZ>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZZZ>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}


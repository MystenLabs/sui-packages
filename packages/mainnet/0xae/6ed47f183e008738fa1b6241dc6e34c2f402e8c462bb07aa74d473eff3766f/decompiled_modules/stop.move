module 0xae6ed47f183e008738fa1b6241dc6e34c2f402e8c462bb07aa74d473eff3766f::stop {
    struct STOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOP>(arg0, 9, b"STOP", b"STOP", b"Some Types Of P", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STOP>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STOP>>(v1);
    }

    // decompiled from Move bytecode v6
}


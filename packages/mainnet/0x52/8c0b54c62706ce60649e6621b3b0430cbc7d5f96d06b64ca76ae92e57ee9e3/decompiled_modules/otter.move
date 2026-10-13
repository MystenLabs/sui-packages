module 0x528c0b54c62706ce60649e6621b3b0430cbc7d5f96d06b64ca76ae92e57ee9e3::otter {
    struct OTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nSui Otter";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"dSui Otter";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<OTTER>(arg0, 6, b"OTTER", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/rMHtatZze5JKSJR1")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTTER>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


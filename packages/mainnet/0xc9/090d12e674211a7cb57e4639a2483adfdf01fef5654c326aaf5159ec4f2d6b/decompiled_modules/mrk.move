module 0xc9090d12e674211a7cb57e4639a2483adfdf01fef5654c326aaf5159ec4f2d6b::mrk {
    struct MRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRK>(arg0, 9, b"MRK", b"MRKo", b"Marco", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MRK>(&mut v2, 13324345000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRK>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xf13b460b2709c7dd783c9beee2a32c36e80b7166820cc517cbbf05da2bd250::gwbh {
    struct GWBH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWBH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWBH>(arg0, 6, b"gwbh", b"gwbh", b"erd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GWBH>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWBH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GWBH>>(v1);
    }

    // decompiled from Move bytecode v6
}


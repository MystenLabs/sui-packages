module 0x49547f96110127410439c98df95444c3ea95146647f8ff3758f0a5a312dd126c::hachi_sui {
    struct HACHI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHI_SUI>(arg0, 9, b"Hachi Sui", b"HACHI", b"Bluemove Pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HACHI_SUI>(&mut v2, 356987412000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHI_SUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HACHI_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


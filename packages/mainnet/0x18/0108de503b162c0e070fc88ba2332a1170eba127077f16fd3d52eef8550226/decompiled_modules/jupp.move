module 0x180108de503b162c0e070fc88ba2332a1170eba127077f16fd3d52eef8550226::jupp {
    struct JUPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUPP>(arg0, 9, b"JUPP", b"JUP", b"JUPJUPJUP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bulltrend-images.s3.amazonaws.com/images/b5a2e4ecfd8a948bb2ab04260db26add9d52566dd00ca08f0d488196ab201205")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUPP>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUPP>>(v2, @0xf55443938e7ecdc1181f60d605c77013d29a4fcf1362658e6fda627cd25cfc2c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUPP>>(v1);
    }

    // decompiled from Move bytecode v6
}


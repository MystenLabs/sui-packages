module 0x920e77939c1672116a7b486f2e261c74e4aeaaffc64646af6799c558916b3b64::kari {
    struct KARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KARI>(arg0, 9, b"Kari", b"Ibo", b"Ibo ibo ibo ibo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KARI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KARI>>(v2, @0xf16666d0ec949f88bc113eca7575f8d7171574600b6f3b635a41dcb06d182ff8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KARI>>(v1);
    }

    // decompiled from Move bytecode v6
}


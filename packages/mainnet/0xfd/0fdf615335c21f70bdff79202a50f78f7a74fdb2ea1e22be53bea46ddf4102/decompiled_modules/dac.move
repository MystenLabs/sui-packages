module 0xfd0fdf615335c21f70bdff79202a50f78f7a74fdb2ea1e22be53bea46ddf4102::dac {
    struct DAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAC>(arg0, 9, b"DAC", b"dark night", b"ad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/329f15e51319ed6c02f23c1388ad9603blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


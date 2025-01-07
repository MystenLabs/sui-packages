module 0xacf44d5004ebe3575c292de0149a4ea90792f9ee9cd873557fb0a75549925b85::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 6, b"PUMP", b"pump king", x"546869732069732070756d70206b696e6720746f6b656e2e0a506c656173652070756d70212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUMP>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v2, @0xb64d6f8b87fa637030ff5ae3e17779e2bfeddd849985a8794ce97846762a499e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}


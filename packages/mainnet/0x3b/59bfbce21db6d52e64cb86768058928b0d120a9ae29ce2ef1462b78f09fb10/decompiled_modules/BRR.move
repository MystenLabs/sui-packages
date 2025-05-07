module 0x3b59bfbce21db6d52e64cb86768058928b0d120a9ae29ce2ef1462b78f09fb10::BRR {
    struct BRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRR>(arg0, 6, b"BRR", b"Brr brr Patapim", b"BRR BRR PATAPIM FUNK BRR BRR PATAPIM FUNK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmagqLij7YeLpYfL5i3VYwQUUu7vMSMBEepLYE6FqapotU")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


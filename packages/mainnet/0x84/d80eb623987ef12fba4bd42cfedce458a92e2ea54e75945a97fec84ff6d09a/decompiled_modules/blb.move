module 0x84d80eb623987ef12fba4bd42cfedce458a92e2ea54e75945a97fec84ff6d09a::blb {
    struct BLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLB>(arg0, 9, b"BLB", b"BLBUL", b"Official fan token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ddb2b52b9da03c03a3e8af453a2e942cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


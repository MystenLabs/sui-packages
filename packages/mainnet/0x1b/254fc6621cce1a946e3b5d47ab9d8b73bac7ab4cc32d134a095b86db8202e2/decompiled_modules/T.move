module 0x1b254fc6621cce1a946e3b5d47ab9d8b73bac7ab4cc32d134a095b86db8202e2::T {
    struct T has drop {
        dummy_field: bool,
    }

    fun init(arg0: T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T>(arg0, 6, b"T", b"H", b"A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmTrPcbjfdYvmtMBcekgsJmFzGnfSQpjvz4QhkpBvBekXb")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


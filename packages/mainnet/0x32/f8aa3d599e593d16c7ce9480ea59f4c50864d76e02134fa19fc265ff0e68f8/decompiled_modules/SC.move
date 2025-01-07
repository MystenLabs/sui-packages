module 0x32f8aa3d599e593d16c7ce9480ea59f4c50864d76e02134fa19fc265ff0e68f8::SC {
    struct SC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SC>(arg0, 6, b"SC", b"test", b"hello", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmTrPcbjfdYvmtMBcekgsJmFzGnfSQpjvz4QhkpBvBekXb")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


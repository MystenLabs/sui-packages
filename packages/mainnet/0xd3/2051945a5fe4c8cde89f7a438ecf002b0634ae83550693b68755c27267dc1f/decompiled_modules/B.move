module 0xd32051945a5fe4c8cde89f7a438ecf002b0634ae83550693b68755c27267dc1f::B {
    struct B has drop {
        dummy_field: bool,
    }

    fun init(arg0: B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B>(arg0, 6, b"B", b"N", b"V", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmTrPcbjfdYvmtMBcekgsJmFzGnfSQpjvz4QhkpBvBekXb")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


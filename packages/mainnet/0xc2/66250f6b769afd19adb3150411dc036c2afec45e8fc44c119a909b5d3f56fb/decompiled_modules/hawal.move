module 0xc266250f6b769afd19adb3150411dc036c2afec45e8fc44c119a909b5d3f56fb::hawal {
    struct HAWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWAL>(arg0, 9, b"haWAL", b"haWAL", b"haWAL is a staking token of WAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.haedal.xyz/logos/hawal.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x297bc228c226306806757c5b5a52948929c9b0d3b0e069542b51edfd7ec7e54b::hawal {
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


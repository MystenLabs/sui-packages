module 0xc400eba93bbe5d87c7c70f01507eecb91467078af3df8888f70e5d3eaca70629::sucemoi {
    struct SUCEMOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCEMOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCEMOI>(arg0, 6, b"SUCEMOI", b"fsdfd", b"fsdfsdfsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1792123250492.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUCEMOI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCEMOI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


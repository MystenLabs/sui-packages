module 0x537f00de482eec273e18be1cb390bfe81852e6e510ee436dc660e55142d00e06::eeew {
    struct EEEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEEW>(arg0, 9, b"EeEw", b"135k", b"fef", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/52439119ef18cd72a2fd425bc5026ec3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EEEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEEW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


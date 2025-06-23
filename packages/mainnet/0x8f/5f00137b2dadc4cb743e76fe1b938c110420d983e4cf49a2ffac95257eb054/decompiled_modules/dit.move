module 0x8f5f00137b2dadc4cb743e76fe1b938c110420d983e4cf49a2ffac95257eb054::dit {
    struct DIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIT>(arg0, 9, b"Dit", b"WorkHard", b"WorkHard every day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2cdf23950af47d2f3c1f0baa5f88752eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


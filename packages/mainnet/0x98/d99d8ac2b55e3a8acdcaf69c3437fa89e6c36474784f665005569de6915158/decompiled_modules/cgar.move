module 0x98d99d8ac2b55e3a8acdcaf69c3437fa89e6c36474784f665005569de6915158::cgar {
    struct CGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CGAR>(arg0, 9, b"CGAR", b"Chill Gary", b"Gary is chill af ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cacecce147335ed3e06f2f4195f424ecblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CGAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CGAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x88a913cd0045b032d76109216cdb79673735d7f7103373839e74fbd0b04af178::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 9, b"SUI", b"aalshukaili", b"Just for my future life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1bf39395ee80e5aea01a3f7d20e174c8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


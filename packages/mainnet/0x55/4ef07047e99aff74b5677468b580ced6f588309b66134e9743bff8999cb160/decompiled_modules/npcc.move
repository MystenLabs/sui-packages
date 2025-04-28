module 0x554ef07047e99aff74b5677468b580ced6f588309b66134e9743bff8999cb160::npcc {
    struct NPCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPCC>(arg0, 9, b"NPCC", b"NPC", b" just make for fun nothing is ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e019f0bae3ed39e5bc41676eeaa72537blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NPCC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPCC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


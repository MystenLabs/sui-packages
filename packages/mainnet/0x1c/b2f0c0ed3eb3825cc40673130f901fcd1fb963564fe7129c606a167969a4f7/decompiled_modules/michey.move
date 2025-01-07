module 0x1cb2f0c0ed3eb3825cc40673130f901fcd1fb963564fe7129c606a167969a4f7::michey {
    struct MICHEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICHEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICHEY>(arg0, 9, b"MICHEY", b"mickey mouse antique doll coin", b"michey mouse antique doll coin 1930s", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e0f08eba3e05cf0d18ec0a27cb85ed7dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MICHEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICHEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


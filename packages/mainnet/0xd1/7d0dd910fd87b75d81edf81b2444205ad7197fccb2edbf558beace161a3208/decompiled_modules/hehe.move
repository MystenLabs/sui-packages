module 0xd17d0dd910fd87b75d81edf81b2444205ad7197fccb2edbf558beace161a3208::hehe {
    struct HEHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHE>(arg0, 9, b"Hehe", b"Hello123", b"aaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d8b9d9cefaff4eed12ae670919a4045ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEHE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


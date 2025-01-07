module 0xf4a9562271630eb13bda36d4c858c16d124ec4c96c4f35808fe0e6cbfc3fdef6::befun {
    struct BEFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEFUN>(arg0, 9, b"BeFUN", b"BoredFun", b"Just a bored on fun world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/72240813374f00b3463903575df8d04fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEFUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEFUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


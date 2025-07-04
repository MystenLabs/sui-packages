module 0x6ba1df68064da2dc2e792399a4c997544d05b2690e74fd515b13b5dbf7e4d2d7::chc {
    struct CHC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHC>(arg0, 9, b"Chc", x"636865726563c3a36f", b"fique milhonario", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6f36a8a841fbec076a022f7426ea591fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


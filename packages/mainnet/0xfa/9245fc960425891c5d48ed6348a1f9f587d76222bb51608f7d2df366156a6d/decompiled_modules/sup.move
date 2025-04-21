module 0xfa9245fc960425891c5d48ed6348a1f9f587d76222bb51608f7d2df366156a6d::sup {
    struct SUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUP>(arg0, 9, b"Sup", b"sup cat", b"ss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/15ca3458db6ce77247579d666c5e825fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


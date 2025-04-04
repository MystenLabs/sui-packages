module 0xa9c705ebd2952a0b9237d03bee79de398a83f3f8b814872d9c15072e3871173::funny {
    struct FUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNNY>(arg0, 9, b"FUNNY", b"Fun", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1d18e9e1023195f03b8ad692ee4b47c1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUNNY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNNY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


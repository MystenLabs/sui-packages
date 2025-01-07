module 0xdded39c4d81e0d082ffa69f84e06837f899fd86c3455fc684bc4dbcb99745bf3::rts {
    struct RTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTS>(arg0, 9, b"RTS", b"the bycicly day ", b"dvbbf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c3b93c5117bc0b76ac1a83ea949abab1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RTS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


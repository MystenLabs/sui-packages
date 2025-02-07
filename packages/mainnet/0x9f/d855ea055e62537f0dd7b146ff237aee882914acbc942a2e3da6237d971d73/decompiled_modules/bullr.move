module 0x9fd855ea055e62537f0dd7b146ff237aee882914acbc942a2e3da6237d971d73::bullr {
    struct BULLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLR>(arg0, 9, b"BULLR", b"bullsrun", b"the write moment for invest in blockchain is now ... take the bulls from horn and fly to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/66a8f3337d7289cf6bcd44a8d30f887dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


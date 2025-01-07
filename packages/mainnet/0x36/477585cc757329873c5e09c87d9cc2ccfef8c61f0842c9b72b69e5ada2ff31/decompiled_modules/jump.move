module 0x36477585cc757329873c5e09c87d9cc2ccfef8c61f0842c9b72b69e5ada2ff31::jump {
    struct JUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUMP>(arg0, 9, b"JUMP", b"Jump Crypto", b"Sui's fastest swap aggregator.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d8cdcb0aa63086861f97d5ec77758069blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


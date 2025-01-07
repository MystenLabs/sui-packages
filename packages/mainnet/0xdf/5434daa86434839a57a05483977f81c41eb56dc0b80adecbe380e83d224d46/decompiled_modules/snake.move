module 0xdf5434daa86434839a57a05483977f81c41eb56dc0b80adecbe380e83d224d46::snake {
    struct SNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAKE>(arg0, 9, b"Snake", b"Snake Coin", b"A meme on SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e5d28cff8479865a288f9bfdf35d3e76blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


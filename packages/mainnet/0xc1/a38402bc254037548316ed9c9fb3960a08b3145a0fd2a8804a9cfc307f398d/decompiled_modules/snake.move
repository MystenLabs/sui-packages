module 0xc1a38402bc254037548316ed9c9fb3960a08b3145a0fd2a8804a9cfc307f398d::snake {
    struct SNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAKE>(arg0, 6, b"SNAKE", b"Snake coin", b"Snake meme coin on SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732459294703.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


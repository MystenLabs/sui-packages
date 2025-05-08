module 0x40af134b3f353b0b57eda4b16f2615d51db544bed0dbb7bf108d2668c39cc9e8::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 9, b"GG", b"gop", b"hjkop vrtv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/942cdebd85ebed1c354f6cc3ef43f764blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x4db7f64802c9f624843deda63ea2d991dce7233da5e5cf809c93ee54cd46a331::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 9, b"FISH", b"Degen Fish", x"f09f909f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1cb4f1a2e5790a7147b5388240511bd2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


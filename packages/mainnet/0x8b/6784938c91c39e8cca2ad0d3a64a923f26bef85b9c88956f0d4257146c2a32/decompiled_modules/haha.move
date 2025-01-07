module 0x8b6784938c91c39e8cca2ad0d3a64a923f26bef85b9c88956f0d4257146c2a32::haha {
    struct HAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAHA>(arg0, 9, b"Haha", b"Haha123", b"123123123123123123123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6b3162cf125c3bc6babfef2f1bec5872blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAHA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


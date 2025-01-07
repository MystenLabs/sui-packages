module 0x258909e99a853233ef54ff4a9e94f917779e27edce081e89f4ed854622c49c61::didi {
    struct DIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDI>(arg0, 6, b"Didi", b"Diddy did it", b"Diddy freak off!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6718_5ef44837f9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}


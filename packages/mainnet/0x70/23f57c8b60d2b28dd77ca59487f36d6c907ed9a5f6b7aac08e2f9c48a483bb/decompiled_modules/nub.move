module 0x7023f57c8b60d2b28dd77ca59487f36d6c907ed9a5f6b7aac08e2f9c48a483bb::nub {
    struct NUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUB>(arg0, 6, b"NUB", b"nubcat", b"nub is a silly cat for the silliest of goobers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_c8a4ebff33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUB>>(v1);
    }

    // decompiled from Move bytecode v6
}


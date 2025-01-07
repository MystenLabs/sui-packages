module 0x661591367c79e8b826e5ab9370d27c3c8aeb99058665a873cf91e52c3ba4ac50::scs {
    struct SCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCS>(arg0, 6, b"SCS", b"Suiky clean", b"The cleanest dog on sui is ready to take over!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5721_90efa09cea.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCS>>(v1);
    }

    // decompiled from Move bytecode v6
}


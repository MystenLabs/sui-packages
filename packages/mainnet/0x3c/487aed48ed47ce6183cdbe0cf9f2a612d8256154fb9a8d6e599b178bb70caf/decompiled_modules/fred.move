module 0x3c487aed48ed47ce6183cdbe0cf9f2a612d8256154fb9a8d6e599b178bb70caf::fred {
    struct FRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRED>(arg0, 6, b"FRED", b"SUI FRED", b"The First Convicted RACCOON \" A New York man who turned a rescued squirrel into a social media star called Peanut is pleading with state authorities to return his beloved pet after they seized it during a raid that also yielded a raccoon named Fred. \"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250110_030224_658_53841eb167.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRED>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x1a1013ccd3b9d24c1834ca379f919e41fb29b97148070b7ca5b887c460344e72::buddy {
    struct BUDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUDDY>(arg0, 6, b"BUDDY", b"Stoner Whale", b"$Buddy The Stoner Whale is the rich, fun uncle of the boys club kids Pepe, Brett, Andy and Landwolf.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_18_19_38_59_c265328e40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}


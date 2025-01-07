module 0x6726620f91bc7ed5c358a31d4068a3ca8391f59a641f9e682d240e573c3ac69e::supersui {
    struct SUPERSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERSUI>(arg0, 6, b"Supersui", b"Sui 2.0", b"Sui super charged ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047423_5dc492c09b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


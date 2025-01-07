module 0x1e9802e1f0644fc31395b8f1254471d7438aa70f8077490fb99e658ab3a0db55::snoop {
    struct SNOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOP>(arg0, 6, b"SNOOP", b"Snoop In Suioup", b"Snoop in sui soup. That's it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016190_27c47ae1d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}


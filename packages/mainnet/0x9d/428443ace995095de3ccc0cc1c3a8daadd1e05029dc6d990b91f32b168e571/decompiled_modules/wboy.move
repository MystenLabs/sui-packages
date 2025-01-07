module 0x9d428443ace995095de3ccc0cc1c3a8daadd1e05029dc6d990b91f32b168e571::wboy {
    struct WBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBOY>(arg0, 6, b"WBOY", b"Waterboy on SUI", b"A waterboy for a college football team discovers he has a unique tackling ability and joins the SUI family.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022324_7c5d8782a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xb8e6df40edddbae0496f60304c53f20afd80a1e9d70bb4e90accb2060e65225a::ghoul {
    struct GHOUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOUL>(arg0, 6, b"GHOUL", b"Ghoulsui", b"Top monster of the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000625546_8f66abc6ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHOUL>>(v1);
    }

    // decompiled from Move bytecode v6
}


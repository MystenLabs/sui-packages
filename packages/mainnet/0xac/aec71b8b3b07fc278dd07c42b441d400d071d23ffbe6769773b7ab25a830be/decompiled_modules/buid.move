module 0xacaec71b8b3b07fc278dd07c42b441d400d071d23ffbe6769773b7ab25a830be::buid {
    struct BUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUID>(arg0, 6, b"Buid", b"buidler", b"There's a new trend on Crypto Twitter   Big crypto accounts are posting \"Builder Szn\" with yellow jacket pictures on their logos.  Feels like it could be the next \"MOG\" cult.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033834_5c12c0e767.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUID>>(v1);
    }

    // decompiled from Move bytecode v6
}


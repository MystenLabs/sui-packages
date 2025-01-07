module 0x20d4d28142dfb07c1b76dce3ec1b62df67cc1463f3e41a5d7f7dd90042df325a::gingcat {
    struct GINGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GINGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GINGCAT>(arg0, 6, b"GingCat", b"Ginger Cat", b"Everybody needs a ginger cat at Christmas time.  Keep smiling with your ginger cat. Feel like you have one now with the Ginger Cat Coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gingercat_b3cd83aed4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GINGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GINGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xf61e0ceb0103ffe11772da8e5cddd42226ead599a52abaac20bfd1ac165f3150::booc {
    struct BOOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOC>(arg0, 6, b"BooC", b"BooCat", b"It's time for halloween and cats come along to celebrate trick or treat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_2_8_9b0351bd82.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOC>>(v1);
    }

    // decompiled from Move bytecode v6
}


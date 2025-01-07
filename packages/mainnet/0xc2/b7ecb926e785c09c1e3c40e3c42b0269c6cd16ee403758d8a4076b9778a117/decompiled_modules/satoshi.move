module 0xc2b7ecb926e785c09c1e3c40e3c42b0269c6cd16ee403758d8a4076b9778a117::satoshi {
    struct SATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHI>(arg0, 6, b"SATOSHI", b"LEN SASSAMAN", b"We are honoring SATOSHI most probable identity, Len Sassaman. This is a unique moment in history and together we will honor Len image, as the Bitcoin founder. May he Rest in Peace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x0c499faceb42c98141409baa13ba812cdc98fdc2_026e0ebce0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}


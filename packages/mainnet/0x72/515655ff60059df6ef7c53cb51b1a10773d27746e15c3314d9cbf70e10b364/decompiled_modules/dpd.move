module 0x72515655ff60059df6ef7c53cb51b1a10773d27746e15c3314d9cbf70e10b364::dpd {
    struct DPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPD>(arg0, 9, b"Dpd", b"Djspday", b"Paydays for the boppers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.vecteezy.com/system/resources/previews/021/796/891/large_2x/dj-mixing-outdoor-at-beach-party-festival-with-crowd-of-people-in-background-summer-nightlife-photo.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DPD>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPD>>(v1);
    }

    // decompiled from Move bytecode v6
}


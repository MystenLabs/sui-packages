module 0x19cd01e187cc2a4e10d12c49cb626525f4f0eac0c3c10b96b9611a9be5ff2f53::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 6, b"HOPCAT", b"Hopcat", b"fat. Oh, no! It's just my natural musculature", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037581_cec0823ad7_295f87b87e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


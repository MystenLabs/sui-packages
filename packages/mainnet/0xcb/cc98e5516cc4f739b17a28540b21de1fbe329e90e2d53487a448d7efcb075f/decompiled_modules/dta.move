module 0xcbcc98e5516cc4f739b17a28540b21de1fbe329e90e2d53487a448d7efcb075f::dta {
    struct DTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTA>(arg0, 6, b"DTA", b"Official Dogtheftauto", b"Official Dogtheftauto!, gathering the Sui top gangsters on this!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3397_eb06d79296.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTA>>(v1);
    }

    // decompiled from Move bytecode v6
}


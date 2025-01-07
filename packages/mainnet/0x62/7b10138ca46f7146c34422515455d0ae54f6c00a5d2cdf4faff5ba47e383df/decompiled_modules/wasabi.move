module 0x627b10138ca46f7146c34422515455d0ae54f6c00a5d2cdf4faff5ba47e383df::wasabi {
    struct WASABI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASABI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASABI>(arg0, 6, b"WASABI", b"Wasabi", b"The cute BEAR of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fer_2f78166305.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASABI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WASABI>>(v1);
    }

    // decompiled from Move bytecode v6
}


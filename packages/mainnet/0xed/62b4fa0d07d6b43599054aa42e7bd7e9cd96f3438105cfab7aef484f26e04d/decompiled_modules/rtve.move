module 0xed62b4fa0d07d6b43599054aa42e7bd7e9cd96f3438105cfab7aef484f26e04d::rtve {
    struct RTVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTVE>(arg0, 6, b"RTVE", b"SPAIN TELEVISION", b"The Spanish Radio and Television Corporation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RTVE_361e643781.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTVE>>(v1);
    }

    // decompiled from Move bytecode v6
}


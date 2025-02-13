module 0x48f5ca6a4c5566bd428c4a83d1a7a218ac62c0e947da6d3635354644942d3f42::uicide {
    struct UICIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UICIDE>(arg0, 6, b"UICIDE", b"Uicid social club", b"The uicide more social on club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000064722_de6b212632.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UICIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UICIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}


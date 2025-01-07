module 0x8730a6418c2b960ffb191b150cd86b78b2f8aade71a57aa4c8aca840cd39634c::bc {
    struct BC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BC>(arg0, 6, b"BC", b"Old Bitcoin", b"Old Bitcoin - The very first and original Bitcoin logo - $BC. Created by Satoshi in 2009", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004507_ab8a099152.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BC>>(v1);
    }

    // decompiled from Move bytecode v6
}


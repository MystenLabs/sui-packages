module 0x868c9d17cdc29c6f981591d16646a221e13fbabc7eec749df0a675a060b5d8a4::bec {
    struct BEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEC>(arg0, 6, b"BEC", b"blue eyed Cat", b"A blue-eyed cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6btmucumawy31_b70948cae4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEC>>(v1);
    }

    // decompiled from Move bytecode v6
}


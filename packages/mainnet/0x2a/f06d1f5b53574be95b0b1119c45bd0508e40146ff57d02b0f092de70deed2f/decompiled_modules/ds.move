module 0x2af06d1f5b53574be95b0b1119c45bd0508e40146ff57d02b0f092de70deed2f::ds {
    struct DS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DS>(arg0, 6, b"DS", b"DEGODS", b"DEGODS Has Come To SUI To Stay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000207209_afe5a27502.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DS>>(v1);
    }

    // decompiled from Move bytecode v6
}


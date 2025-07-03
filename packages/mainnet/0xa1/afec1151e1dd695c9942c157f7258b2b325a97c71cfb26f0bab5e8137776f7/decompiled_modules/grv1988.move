module 0xa1afec1151e1dd695c9942c157f7258b2b325a97c71cfb26f0bab5e8137776f7::grv1988 {
    struct GRV1988 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRV1988, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRV1988>(arg0, 6, b"Grv1988", b"Geraviti", b"This is an artificial intelligence monkey, and its project engineer is an anonymous doctor in Sweden. This project will move to the next phases if it is popular.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012822_ebf5a43c6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRV1988>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRV1988>>(v1);
    }

    // decompiled from Move bytecode v6
}


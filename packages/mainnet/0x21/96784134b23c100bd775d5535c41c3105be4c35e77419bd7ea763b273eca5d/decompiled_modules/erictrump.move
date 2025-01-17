module 0x2196784134b23c100bd775d5535c41c3105be4c35e77419bd7ea763b273eca5d::erictrump {
    struct ERICTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERICTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERICTRUMP>(arg0, 6, b"ERICTRUMP", b"Eric Trump", x"457865637574697665205669636520507265736964656e74206f6620546865200a5472756d70204f7267616e697a6174696f6e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2227_006a181256.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERICTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERICTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}


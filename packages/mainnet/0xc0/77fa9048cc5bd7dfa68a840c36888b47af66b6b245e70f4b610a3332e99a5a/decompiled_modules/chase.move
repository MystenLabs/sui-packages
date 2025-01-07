module 0xc077fa9048cc5bd7dfa68a840c36888b47af66b6b245e70f4b610a3332e99a5a::chase {
    struct CHASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHASE>(arg0, 6, b"Chase", b"Chasing Sui", b"Early Buyer Become Millionare !!!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11_f73d30d299.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHASE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHASE>>(v1);
    }

    // decompiled from Move bytecode v6
}


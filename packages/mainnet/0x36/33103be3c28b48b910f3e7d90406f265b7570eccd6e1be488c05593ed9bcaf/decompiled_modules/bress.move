module 0x3633103be3c28b48b910f3e7d90406f265b7570eccd6e1be488c05593ed9bcaf::bress {
    struct BRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRESS>(arg0, 6, b"BRESS", b"Bress", b"Hi it's me Bress, smallest shark on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vress_b595972e64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRESS>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x83646c264e6653fd5d0452d7979b288719d80fa20d72a5873300e8bd7404a8f3::gus {
    struct GUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUS>(arg0, 6, b"GUS", b"GUSDOG", b"this is gus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2a44079fbea9236d713ab6431dd5fd78_09032064be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUS>>(v1);
    }

    // decompiled from Move bytecode v6
}


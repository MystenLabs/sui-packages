module 0xa222e89a42e929eb7b249788ec9f6334c5d8df530f22fe341576ed8b3f7b4fe2::suger {
    struct SUGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGER>(arg0, 6, b"SUGER", b"Glucose", b"Life needs energy, your portfolio needs $SUGAR.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_N9_U6f8t_400x400_aa843ca4a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGER>>(v1);
    }

    // decompiled from Move bytecode v6
}


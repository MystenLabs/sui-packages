module 0x45a0d083c12d7ba4fe03bbaebc48383c4edbc07f5537017e17261508ec345602::t90 {
    struct T90 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T90, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T90>(arg0, 6, b"T90", b"Sui Tank", b"The strongest of Sui army, it can join battle any where under any weather conditions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/T_90_4404beb156.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T90>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T90>>(v1);
    }

    // decompiled from Move bytecode v6
}


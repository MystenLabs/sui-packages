module 0x9472bc3109e1f6fdc39c398fe644a25f5d0632eba5b1f216c420c1cfbb74d7f::m {
    struct M has drop {
        dummy_field: bool,
    }

    fun init(arg0: M, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M>(arg0, 6, b"M", b"Millionaire", b"Everyone is a millionaire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_ae_a_c_a_c_9c184e30a2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<M>>(v1);
    }

    // decompiled from Move bytecode v6
}


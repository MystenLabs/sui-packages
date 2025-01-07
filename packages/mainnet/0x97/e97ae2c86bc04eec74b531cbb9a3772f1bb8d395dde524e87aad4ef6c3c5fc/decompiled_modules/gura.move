module 0x97e97ae2c86bc04eec74b531cbb9a3772f1bb8d395dde524e87aad4ef6c3c5fc::gura {
    struct GURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GURA>(arg0, 6, b"GURA", b"GURARA", b"Lifes too short not to be cute and kind, dont you think?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b40546af3dc371824ec26339d71fb31c_9149f23362.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GURA>>(v1);
    }

    // decompiled from Move bytecode v6
}


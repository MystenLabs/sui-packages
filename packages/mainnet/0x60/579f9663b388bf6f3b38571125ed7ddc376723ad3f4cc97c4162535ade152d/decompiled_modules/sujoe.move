module 0x60579f9663b388bf6f3b38571125ed7ddc376723ad3f4cc97c4162535ade152d::sujoe {
    struct SUJOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUJOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUJOE>(arg0, 6, b"Sujoe", b"suijoe", b"petok petok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/juhgjh_15404e0989.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUJOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUJOE>>(v1);
    }

    // decompiled from Move bytecode v6
}


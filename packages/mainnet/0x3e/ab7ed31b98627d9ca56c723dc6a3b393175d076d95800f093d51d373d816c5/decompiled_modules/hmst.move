module 0x3eab7ed31b98627d9ca56c723dc6a3b393175d076d95800f093d51d373d816c5::hmst {
    struct HMST has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMST>(arg0, 6, b"Hmst", b"Hamster Kombat", b"Hamster Kombat On SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009562_c03f995797.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMST>>(v1);
    }

    // decompiled from Move bytecode v6
}


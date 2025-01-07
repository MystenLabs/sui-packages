module 0x55dadf836a5cc973ef738bd75902f0451b30b49cd55ffaff730f1817326f89d9::dm {
    struct DM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DM>(arg0, 6, b"Dm", b"Dog man", b"Doggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9a891d37_a29f_4e15_b0fe_642d674407b7_fa60eae908.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DM>>(v1);
    }

    // decompiled from Move bytecode v6
}


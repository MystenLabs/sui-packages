module 0x27ba8fe728945a65dd9e68730fa7aa464196a5c6f10b7eee9e2f47c49c563a2::uchiha {
    struct UCHIHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UCHIHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UCHIHA>(arg0, 6, b"Uchiha", b"Shisui", b"You know how strong my family is, we will help you reach the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000594_f1c6b056d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCHIHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UCHIHA>>(v1);
    }

    // decompiled from Move bytecode v6
}


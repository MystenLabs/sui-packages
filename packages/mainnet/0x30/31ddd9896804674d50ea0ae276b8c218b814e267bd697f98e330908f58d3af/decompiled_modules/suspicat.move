module 0x3031ddd9896804674d50ea0ae276b8c218b814e267bd697f98e330908f58d3af::suspicat {
    struct SUSPICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSPICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSPICAT>(arg0, 6, b"SUSPICAT", b"The Suspicious Cat", x"45766572796f6e65206c6f76657320636174732c206275742077686f206c6f76657320612073757370656374206361743f0a4c6574277320637265617465206120737573706963696f75732c20636c6f73652d6b6e697420636f6d6d756e69747920746f67657468657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_A_l_A_chargement_e78c26d9fb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSPICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSPICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


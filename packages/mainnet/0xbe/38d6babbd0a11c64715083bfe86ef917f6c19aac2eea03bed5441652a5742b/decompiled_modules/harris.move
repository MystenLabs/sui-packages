module 0xbe38d6babbd0a11c64715083bfe86ef917f6c19aac2eea03bed5441652a5742b::harris {
    struct HARRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARRIS>(arg0, 6, b"HARRIS", b"Kamala Harris on Sui", x"546865203173742024484152524953206465706c6f796564206f6e205375692c20636f6d6d756e6974792d6d616e616765642e0a5468652068656972206170706172656e74202e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_l1600_ceeecd9459.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARRIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARRIS>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x2dd6386d5584e9949dce4aaddcfce6ef92ae07bf60539da1c286558e2a42839b::exodus {
    struct EXODUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXODUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXODUS>(arg0, 6, b"EXODUS", b"Exodus", b"Exodus Labs Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chrollo_3139ec406d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXODUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EXODUS>>(v1);
    }

    // decompiled from Move bytecode v6
}


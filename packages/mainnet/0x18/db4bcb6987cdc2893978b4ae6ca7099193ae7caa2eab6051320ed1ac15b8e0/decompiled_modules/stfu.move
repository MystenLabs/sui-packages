module 0x18db4bcb6987cdc2893978b4ae6ca7099193ae7caa2eab6051320ed1ac15b8e0::stfu {
    struct STFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: STFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STFU>(arg0, 6, b"STFU", b"SHUT UP AND TAKE MY MONEY", b"shut the f*k up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GWP_Nhuu_Xc_AMQG_Nr_28eea8ce1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STFU>>(v1);
    }

    // decompiled from Move bytecode v6
}


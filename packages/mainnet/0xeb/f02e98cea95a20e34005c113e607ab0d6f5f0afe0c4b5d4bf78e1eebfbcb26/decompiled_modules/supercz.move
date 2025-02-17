module 0xebf02e98cea95a20e34005c113e607ab0d6f5f0afe0c4b5d4bf78e1eebfbcb26::supercz {
    struct SUPERCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERCZ>(arg0, 6, b"SUPERCZ", b"Super CZ", b"Everything is arranged for the best. Happy Thanksgiving!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C2l0_Jw_Sp_400x400_afdcb9b46e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERCZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERCZ>>(v1);
    }

    // decompiled from Move bytecode v6
}


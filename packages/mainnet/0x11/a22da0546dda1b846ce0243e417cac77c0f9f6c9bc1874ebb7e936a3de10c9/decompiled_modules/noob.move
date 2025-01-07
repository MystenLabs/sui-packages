module 0x11a22da0546dda1b846ce0243e417cac77c0f9f6c9bc1874ebb7e936a3de10c9::noob {
    struct NOOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOOB>(arg0, 6, b"Noob", b"Noob on Sui", b"First coin deployed on Roblox", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0nn5yhmk_400x400_e761ca18f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOOB>>(v1);
    }

    // decompiled from Move bytecode v6
}


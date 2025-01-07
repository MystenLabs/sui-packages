module 0x7799c02e7db0a0077103d0680dc065c09b3a685d9f08fae92ef104b6c9a383a1::pimp {
    struct PIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIMP>(arg0, 6, b"PIMP", b"Sui Pimp", b"Welcome to the coop of PIMP Coin, the memecoin that's shaking up the pecking order on the SUI blockchain! We're not just winging it we're here to ruffle feathers and add a splash of fun to the crypto barnyard.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/New_Project_2024_09_22_T225821_268_6cf4566f6a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}


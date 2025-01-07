module 0x19b68de6a17be1fac9043faa550150b558edb7ed27cddd044828723aebe6f7af::suimarket {
    struct SUIMARKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMARKET>(arg0, 6, b"SuiMarket", b"Sui Market", b" First prediction market on the Sui network. Trade anything instantly in seconds!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S_logo_1_0fb070ba32.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMARKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMARKET>>(v1);
    }

    // decompiled from Move bytecode v6
}


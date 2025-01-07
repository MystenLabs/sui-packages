module 0x997de689a0a68d79aadc8a3bca55fd22e276ae2c874a1db2abb90d35b7ecaf93::hayley {
    struct HAYLEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAYLEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAYLEY>(arg0, 6, b"HAYLEY", b"HAYLEY SUI", x"46524f4d20544845205354524545545320544f20544845205345412c204956452054524144454420414354495649534d20464f52204151554154494320424c4953532e20494d204b4c4155535320574946452c20414e44204e4f5720495645204245434f4d452041204d454d452e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xb11f7b40e084f16bf4a246e9d97331cddb1778a5_d4ae195feb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAYLEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAYLEY>>(v1);
    }

    // decompiled from Move bytecode v6
}


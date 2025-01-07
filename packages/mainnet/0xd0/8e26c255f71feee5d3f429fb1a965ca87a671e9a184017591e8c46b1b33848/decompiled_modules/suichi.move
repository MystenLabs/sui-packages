module 0xd08e26c255f71feee5d3f429fb1a965ca87a671e9a184017591e8c46b1b33848::suichi {
    struct SUICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHI>(arg0, 9, b"SUICHI", b"Suichi Roll", b"SuichiRoll: The tastiest token on Sui! Packed with value and fun, it's the perfect roll for smooth transactions in the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1508815975092740101/3BXNNl3S.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICHI>(&mut v2, 4000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHI>>(v1);
    }

    // decompiled from Move bytecode v6
}


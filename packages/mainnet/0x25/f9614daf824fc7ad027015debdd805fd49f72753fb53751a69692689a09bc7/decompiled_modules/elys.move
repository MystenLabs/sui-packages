module 0x25f9614daf824fc7ad027015debdd805fd49f72753fb53751a69692689a09bc7::elys {
    struct ELYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELYS>(arg0, 9, b"ELYS", b"ELYS", b"Universal Liquidity Layer: multichain UniFi, one click away.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1731847599370420224/qCiGEbe0_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELYS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELYS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}


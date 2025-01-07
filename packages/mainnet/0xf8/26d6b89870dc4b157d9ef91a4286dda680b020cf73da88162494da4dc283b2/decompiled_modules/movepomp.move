module 0xf826d6b89870dc4b157d9ef91a4286dda680b020cf73da88162494da4dc283b2::movepomp {
    struct MOVEPOMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEPOMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEPOMP>(arg0, 6, b"MOVEPOMP", b"MOVE POMP", b"Introducing a coin that you can trade instantly with just one click on the Sui network, all for a tiny fee! The First Meme Fair Launch Platform on SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yc_H_Xpyb_YA_Auypp_68cc09bdde.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEPOMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEPOMP>>(v1);
    }

    // decompiled from Move bytecode v6
}


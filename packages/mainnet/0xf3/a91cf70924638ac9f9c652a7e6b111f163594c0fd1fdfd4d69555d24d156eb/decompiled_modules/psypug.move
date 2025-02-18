module 0xf3a91cf70924638ac9f9c652a7e6b111f163594c0fd1fdfd4d69555d24d156eb::psypug {
    struct PSYPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSYPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSYPUG>(arg0, 6, b"PsyPug", b"Psycho Pug", x"50737963686f205075672028245053595055472920e2809320546865206372617a696573742c20686967682d656e65726779206d656d6520746f6b656e21204675656c6564206279206368616f7320616e6420646567656e657261746520687970652c2024505359505547206973206865726520746f2074616b65206f7665722e2041706520696e20666f72206c6175676873206f72207269646520697420746f20746865206d6f6f6ee2809474686973207075672069736ee280997420736c6f77696e6720646f776e2120f09f9a80f09f90b6f09f92a52023505359505547", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739920412295.37")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSYPUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSYPUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


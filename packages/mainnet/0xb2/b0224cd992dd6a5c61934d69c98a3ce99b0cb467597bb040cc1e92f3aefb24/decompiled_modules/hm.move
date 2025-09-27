module 0xb2b0224cd992dd6a5c61934d69c98a3ce99b0cb467597bb040cc1e92f3aefb24::hm {
    struct HM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HM>(arg0, 9, b"HM", b"homie", b"c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/G4dKYMjEcbjVl-miLDrCsYqeMIID6OsqCzHy9AyJlZ0")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HM>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HM>>(v1);
    }

    // decompiled from Move bytecode v6
}


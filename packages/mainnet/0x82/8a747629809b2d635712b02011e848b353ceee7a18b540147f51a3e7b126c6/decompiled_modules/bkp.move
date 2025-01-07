module 0x828a747629809b2d635712b02011e848b353ceee7a18b540147f51a3e7b126c6::bkp {
    struct BKP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKP>(arg0, 6, b"BKP", b"Binky Pup", b"Cutest troublemaker in townBinky Pup!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4794c6203b9650f968248b529614dfb3_0bfc4360d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BKP>>(v1);
    }

    // decompiled from Move bytecode v6
}


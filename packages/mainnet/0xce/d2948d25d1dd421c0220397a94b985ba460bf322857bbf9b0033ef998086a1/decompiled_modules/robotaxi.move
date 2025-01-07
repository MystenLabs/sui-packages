module 0xced2948d25d1dd421c0220397a94b985ba460bf322857bbf9b0033ef998086a1::robotaxi {
    struct ROBOTAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOTAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOTAXI>(arg0, 6, b"ROBOTAXI", b"SUIROBOTAXI", b"Ride the future. Own the journey. $ROBOTAX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_D_Ui1hwt_400x400_4595afe62c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOTAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOTAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}


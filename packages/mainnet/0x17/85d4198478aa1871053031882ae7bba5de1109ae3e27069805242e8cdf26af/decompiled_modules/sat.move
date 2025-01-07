module 0x1785d4198478aa1871053031882ae7bba5de1109ae3e27069805242e8cdf26af::sat {
    struct SAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAT>(arg0, 6, b"SAT", b"Seal Cat", b"Seal Soul, Cat Vibes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_15_02_23_57_48a595d1a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


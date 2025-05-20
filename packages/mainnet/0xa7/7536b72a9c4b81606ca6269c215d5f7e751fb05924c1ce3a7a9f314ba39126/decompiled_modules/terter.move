module 0xa77536b72a9c4b81606ca6269c215d5f7e751fb05924c1ce3a7a9f314ba39126::terter {
    struct TERTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERTER>(arg0, 9, b"ertert", b"terter", b"ertertret", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9900/kappa/coins/18c57e6a-9348-4802-a774-a7f3a68c0516.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TERTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xcbd480f670c70232ad52ab12b56f81e6bfc870b14ae4e2af6e40426458450478::mvg {
    struct MVG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVG>(arg0, 9, b"MVG", b"monivong", b"monivong coins provides discounts at monivong.store", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MVG>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MVG>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xdcfbfec41efb75021fb1e686306f227a2bb6e1aff86a6b8ec0ec2945b84f994d::puffer {
    struct PUFFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFER>(arg0, 6, b"Puffer", b"Puffer on Sui", b"(Re)staking for little fish. Earn while decentralizing Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/puf2_acc263b8ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFER>>(v1);
    }

    // decompiled from Move bytecode v6
}


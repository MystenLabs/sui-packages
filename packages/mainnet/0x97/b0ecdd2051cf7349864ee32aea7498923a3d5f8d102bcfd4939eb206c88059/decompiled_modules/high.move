module 0x97b0ecdd2051cf7349864ee32aea7498923a3d5f8d102bcfd4939eb206c88059::high {
    struct HIGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIGH>(arg0, 6, b"HIGH", b"Ember High Income", b"This receipt token represents the shares a user has of the Ember High Income Vault on Ember Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.bluefin.io/images/HIGH.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIGH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIGH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}


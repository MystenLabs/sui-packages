module 0xc7deda9199d8e20d10de32bb5214b0aad7e23aaff8196c4675f19fb01b84212d::nsi {
    struct NSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSI>(arg0, 9, b"NSI", b"NADSUI", b"Monad on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7e76933e43b3c6d13040bb18f9c9a925blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


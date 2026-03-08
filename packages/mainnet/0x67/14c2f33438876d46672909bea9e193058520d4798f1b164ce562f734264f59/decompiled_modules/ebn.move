module 0x6714c2f33438876d46672909bea9e193058520d4798f1b164ce562f734264f59::ebn {
    struct EBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBN>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"EBN", b"Ebuen", b"First", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EBN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


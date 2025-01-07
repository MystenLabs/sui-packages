module 0x5e723d01b65767a56b889771dc282f1ff5336031ec9caac65a7d3a5c39d51ade::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOK>(arg0, 6, b"COOK", b"CHEF COOK ON SUI ", x"4c6f6f6b20746f2074686520736b79206d6f7265206f6674656e2c20736f6d652061697264726f70206973206c616e64696e67206f6e20796f75f09faa820a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731524760711.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


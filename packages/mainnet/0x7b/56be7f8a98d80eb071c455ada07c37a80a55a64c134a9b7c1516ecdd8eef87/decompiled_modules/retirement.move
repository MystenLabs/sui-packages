module 0x7b56be7f8a98d80eb071c455ada07c37a80a55a64c134a9b7c1516ecdd8eef87::retirement {
    struct RETIREMENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETIREMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETIREMENT>(arg0, 6, b"Retirement", b"Early Retirement", x"49276d203530207965617273206f6c642e200a0a52756e6e696e67206f6e2074686520666961742074726561646d696c6c20616e642067657474696e6720706f6f7265722065616368206461792062656361757365206f6620676f7665726e6d656e74206d6f6e6579207072696e74696e672e204920646f6e277420686176652061207765627369746520616e6420646f6e2774206b6e6f7720686f7720746f20736574206f6e652075702e204c657473206861766520736f6d652066756e20616e64207365652069662077652063616e20616c6c20726574697265206561726c792e200a0a4c6f766520796f7520616c6c2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732711506943.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RETIREMENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETIREMENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


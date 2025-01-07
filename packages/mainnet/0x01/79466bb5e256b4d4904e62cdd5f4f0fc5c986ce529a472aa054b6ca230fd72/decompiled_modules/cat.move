module 0x179466bb5e256b4d4904e62cdd5f4f0fc5c986ce529a472aa054b6ca230fd72::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"TurboCat", b"First cat on Turbos!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730994571026.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


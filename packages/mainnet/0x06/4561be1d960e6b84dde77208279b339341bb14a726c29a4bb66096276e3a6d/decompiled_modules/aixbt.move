module 0x64561be1d960e6b84dde77208279b339341bb14a726c29a4bb66096276e3a6d::aixbt {
    struct AIXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIXBT>(arg0, 6, b"AIXBT", b"AIXBT", b"AIXBT tracks CT discussions and leverages its proprietary engine to identify high momentum plays, and play games...AIXBT token holders gain access to its analytics platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/name_34c4330acc_4e675fe494.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIXBT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIXBT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


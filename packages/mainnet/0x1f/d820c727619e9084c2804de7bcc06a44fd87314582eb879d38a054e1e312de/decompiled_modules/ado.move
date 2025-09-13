module 0x1fd820c727619e9084c2804de7bcc06a44fd87314582eb879d38a054e1e312de::ado {
    struct ADO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADO>(arg0, 6, b"ADO", b"ADO SUI", b"WE GOT THE POWER OF ANIME AND THE DEFI ON US!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1757805656074.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


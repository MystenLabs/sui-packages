module 0x18b24aefcf500a4ca1ea267a48f6e426ac1484116fd6dfd839fd6a363cf57538::mcga {
    struct MCGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCGA>(arg0, 6, b"MCGA", b"Make Crypto Great", b"Make Crypto Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731835289529.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x25e02e070ee9197dd8ae4a2ac988e626593ed2cda4e63444c293af9579cc1b24::mcga {
    struct MCGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCGA>(arg0, 6, b"MCGA", b"Make Crypto Great Ag", b"Make Crypto Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731834855543.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


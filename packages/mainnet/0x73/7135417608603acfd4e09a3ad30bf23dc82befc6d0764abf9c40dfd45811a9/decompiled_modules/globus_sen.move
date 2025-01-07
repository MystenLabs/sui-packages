module 0x737135417608603acfd4e09a3ad30bf23dc82befc6d0764abf9c40dfd45811a9::globus_sen {
    struct GLOBUS_SEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOBUS_SEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOBUS_SEN>(arg0, 9, b"GLOBUS_SEN", b"Globus", b"Glibus sence activ moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/766e7f7b-afdc-4cc1-9bfd-60a491cafbe4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOBUS_SEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLOBUS_SEN>>(v1);
    }

    // decompiled from Move bytecode v6
}


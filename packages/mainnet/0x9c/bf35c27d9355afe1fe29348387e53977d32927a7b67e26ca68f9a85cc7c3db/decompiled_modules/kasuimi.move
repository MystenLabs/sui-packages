module 0x9cbf35c27d9355afe1fe29348387e53977d32927a7b67e26ca68f9a85cc7c3db::kasuimi {
    struct KASUIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KASUIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KASUIMI>(arg0, 6, b"KASUIMI", b"KASUIMI GIRL", b"Whispers of Suinago Kasumi's Digital Heart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737393125347.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KASUIMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KASUIMI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


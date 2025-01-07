module 0xc6fc8955b7ddf4994c06a9263f45a468c03497ea7b5f10a0665fca24398b0193::shg {
    struct SHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHG>(arg0, 6, b"SHG", b"SuiChill Guy", b"The thesis is simple, this is the OG SUI Chill Guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732957509924.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


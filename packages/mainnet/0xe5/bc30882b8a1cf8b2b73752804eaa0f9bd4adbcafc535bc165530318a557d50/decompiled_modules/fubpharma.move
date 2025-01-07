module 0xe5bc30882b8a1cf8b2b73752804eaa0f9bd4adbcafc535bc165530318a557d50::fubpharma {
    struct FUBPHARMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUBPHARMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUBPHARMA>(arg0, 6, b"FUBPharma", b"Fuck Big Pharma", b"Making America healthy again will disrupt the corrupt healthcare \"medicine\" industry and critical thinking will become normal again. Time to take back our health our minds and our freedom! FUCK BIG PHARMA!!!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731510711816.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUBPHARMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUBPHARMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


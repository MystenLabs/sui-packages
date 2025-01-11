module 0x99592b88718d4a8cb37b47665a758b3fc7ad85e6fbde6c6b48d5fe079ae78365::bbsuiyan {
    struct BBSUIYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBSUIYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBSUIYAN>(arg0, 6, b"BBSUIYAN", b"Baby SUIYAN", b"Baby SuiYan is the adorable, youthful form of SuiYan, brimming with pure energy and limitless potential. Despite his small size, he shows an innate talent for controlling elemental forces, always holding a glowing droplet of water in his tiny hand. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736579447896.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBSUIYAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBSUIYAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


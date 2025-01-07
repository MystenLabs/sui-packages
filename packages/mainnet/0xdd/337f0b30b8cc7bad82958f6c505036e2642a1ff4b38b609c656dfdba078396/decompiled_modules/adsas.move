module 0xdd337f0b30b8cc7bad82958f6c505036e2642a1ff4b38b609c656dfdba078396::adsas {
    struct ADSAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADSAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADSAS>(arg0, 6, b"Adsas", b"a", b"ssa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730998202555.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADSAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADSAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


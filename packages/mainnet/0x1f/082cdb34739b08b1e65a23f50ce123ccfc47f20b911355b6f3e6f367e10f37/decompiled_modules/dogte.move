module 0x1f082cdb34739b08b1e65a23f50ce123ccfc47f20b911355b6f3e6f367e10f37::dogte {
    struct DOGTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGTE>(arg0, 9, b"DOGTE", b"Dog cute", b"a dog so cute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d621157d-808f-4d93-8938-310ced3757fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGTE>>(v1);
    }

    // decompiled from Move bytecode v6
}


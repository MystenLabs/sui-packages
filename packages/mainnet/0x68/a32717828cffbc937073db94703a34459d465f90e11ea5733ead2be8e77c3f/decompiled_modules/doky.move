module 0x68a32717828cffbc937073db94703a34459d465f90e11ea5733ead2be8e77c3f::doky {
    struct DOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOKY>(arg0, 6, b"DOKY", b"Doky", b"Doky is unique memecoin on the sui blockchain, created to bring boundless joy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731048810916.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


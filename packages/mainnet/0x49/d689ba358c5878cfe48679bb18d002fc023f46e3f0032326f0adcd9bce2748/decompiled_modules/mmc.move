module 0x49d689ba358c5878cfe48679bb18d002fc023f46e3f0032326f0adcd9bce2748::mmc {
    struct MMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMC>(arg0, 9, b"MMC", b"Mucawet", b"Lfg sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7e321dfbe070dc4be103081f7dc4e462blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xfac62477234173a074d199e2574546caff52e559f99720b649c027faa88973eb::boobsui {
    struct BOOBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBSUI>(arg0, 6, b"BOOBsui", b"BoOB", b"BOOB BOOB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746396837013.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOBSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


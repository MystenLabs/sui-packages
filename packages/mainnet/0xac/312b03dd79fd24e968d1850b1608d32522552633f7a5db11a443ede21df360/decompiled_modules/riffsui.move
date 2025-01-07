module 0xac312b03dd79fd24e968d1850b1608d32522552633f7a5db11a443ede21df360::riffsui {
    struct RIFFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIFFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIFFSUI>(arg0, 6, b"Riffsui", b"Rifsui", b"Riff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731950996185.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIFFSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIFFSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xdd5941f1e07778f322991114298b65541059775b1c390e04193781fc03b1071e::heartt {
    struct HEARTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEARTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEARTT>(arg0, 6, b"Heartt", b"heart", b"Heartttkqlsnlqksklqklsl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1769986411191.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEARTT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEARTT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


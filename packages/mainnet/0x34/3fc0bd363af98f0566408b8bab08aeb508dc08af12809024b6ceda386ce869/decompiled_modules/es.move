module 0x343fc0bd363af98f0566408b8bab08aeb508dc08af12809024b6ceda386ce869::es {
    struct ES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ES>(arg0, 6, b"Es", b"Esquilo", b"venho para ficar ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732285812120.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


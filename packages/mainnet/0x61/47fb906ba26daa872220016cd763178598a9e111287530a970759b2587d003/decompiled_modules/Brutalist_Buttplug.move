module 0x6147fb906ba26daa872220016cd763178598a9e111287530a970759b2587d003::Brutalist_Buttplug {
    struct BRUTALIST_BUTTPLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUTALIST_BUTTPLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUTALIST_BUTTPLUG>(arg0, 9, b"BRUTAL", b"Brutalist Buttplug", b"yes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzaXXlrXAAA0ui6?format=png&name=900x900")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRUTALIST_BUTTPLUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUTALIST_BUTTPLUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


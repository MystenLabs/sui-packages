module 0xf89ceda8635bf0b379e077a6bfb1f03206b4f4da8e34005aae4d56658b54f102::Meds {
    struct MEDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEDS>(arg0, 9, b"MEDS", b"Meds", b"take your meds. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G0A6D2zW0AABA3o?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


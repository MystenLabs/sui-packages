module 0xee0c1bf0b1efa4d8981393e1f727fb50cd4ff44592b5ab0179d5236045bd4472::charge {
    struct CHARGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARGE>(arg0, 6, b"Charge", b"Please Charge", b"Butt Meta Just Hold me Tight ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/please_charge_low_battery_funny_sexy_panties_geekyget_db118b7be9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHARGE>>(v1);
    }

    // decompiled from Move bytecode v6
}


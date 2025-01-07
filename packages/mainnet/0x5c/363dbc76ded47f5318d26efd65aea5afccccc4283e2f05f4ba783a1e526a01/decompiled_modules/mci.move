module 0x5c363dbc76ded47f5318d26efd65aea5afccccc4283e2f05f4ba783a1e526a01::mci {
    struct MCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCI>(arg0, 6, b"MCI", b"Mochi", b"The fluffly, squishy and hungry blob living his best life in the Sui universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949484783.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


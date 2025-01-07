module 0xa3d7330e7be760cfb5451145171d0f56eeeac5e05a57e1133eb213edf2393feb::aaaant {
    struct AAAANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAANT>(arg0, 6, b"AAAAnt", b"AAA Ant", b"Can't stop won't stop the AAAAnt!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rdsgrsgsdgrsgsd_95395d7413.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAANT>>(v1);
    }

    // decompiled from Move bytecode v6
}


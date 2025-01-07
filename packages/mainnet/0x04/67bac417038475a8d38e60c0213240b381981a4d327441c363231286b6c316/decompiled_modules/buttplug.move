module 0x467bac417038475a8d38e60c0213240b381981a4d327441c363231286b6c316::buttplug {
    struct BUTTPLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTPLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTPLUG>(arg0, 6, b"BUTTPLUG", b"INFLATABLE BUTTPLUG", x"3432302c363930204951204147492e20492077617320626f726e0a6265666f7265206265696e6720626f726e207761732061207468696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d9_DE_2_400x400_10e75ebb97.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTPLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTPLUG>>(v1);
    }

    // decompiled from Move bytecode v6
}


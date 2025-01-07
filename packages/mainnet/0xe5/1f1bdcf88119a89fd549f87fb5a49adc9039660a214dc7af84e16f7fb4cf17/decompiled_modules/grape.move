module 0xe51f1bdcf88119a89fd549f87fb5a49adc9039660a214dc7af84e16f7fb4cf17::grape {
    struct GRAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAPE>(arg0, 6, b"GRAPE", b"Grapefruit", b"Grapefruit issister of dogwif", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ec415_Vlz_400x400_d90371bd12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}


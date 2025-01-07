module 0xa30dece4f5475f85b1d9a03f57fba946a9624809ade6c8501678bb36217b0cfa::flytrump {
    struct FLYTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLYTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLYTRUMP>(arg0, 6, b"FlyTrump", b"Fly Trump", b"Trump is flying and we will fly with him to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046578_16fff36899.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLYTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLYTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}


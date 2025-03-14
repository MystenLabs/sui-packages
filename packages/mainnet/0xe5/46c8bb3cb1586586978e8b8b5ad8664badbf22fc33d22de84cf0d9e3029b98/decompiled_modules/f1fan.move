module 0xe546c8bb3cb1586586978e8b8b5ad8664badbf22fc33d22de84cf0d9e3029b98::f1fan {
    struct F1FAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: F1FAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<F1FAN>(arg0, 6, b"F1fan", b"F1_fan", b"F1 Exclusive Content. Social Media. Access to Telegram Premium. Live Streams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053834_707114a1bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F1FAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<F1FAN>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xb7f082d753497529295899c7e072705fe70f1f2458d60ea49153573f6cfa1b9a::doge1 {
    struct DOGE1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE1>(arg0, 6, b"DOGE1", b"Dogecoin", b"Doge on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/3dee13e7-26fb-437e-9159-4a3c18535517.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


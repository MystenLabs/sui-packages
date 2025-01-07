module 0x371a0c22e963411d1a2fbdc2ca735f1b67ab6c956056c27e348c13c4818bd19a::dni00001 {
    struct DNI00001 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNI00001, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNI00001>(arg0, 6, b"DNI00001", b"DO NOT INVESTIGATE", x"4a5553542044454c455445204954200a444f4e542052454144204954200a444f4e5420494e5645535449474154450a68747470733a2f2f796f7574752e62652f36525f505f356f556857383f73693d657a59616a42654d5673323135655974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_31c3ab1182.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNI00001>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNI00001>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x1ee49628b3ad55db3c55288673acd92c38a6275839719b0b337de8a9888d3e32::yantsi {
    struct YANTSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YANTSI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<YANTSI>(arg0, 6, b"YANTSI", b"Yantsi", b"PAOK Greek fan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000000605_b1d1adb621.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YANTSI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YANTSI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


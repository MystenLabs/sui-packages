module 0xf8d4c17f34581bbf45ae9adcdbe6e00c01ed5d2b1ec404bab914f5ae99628c9b::tlov {
    struct TLOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: TLOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TLOV>(arg0, 9, b"TLov", b"True Love", b"true love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1f214744719f921e1e1dcf91ee2f0b41blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TLOV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TLOV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


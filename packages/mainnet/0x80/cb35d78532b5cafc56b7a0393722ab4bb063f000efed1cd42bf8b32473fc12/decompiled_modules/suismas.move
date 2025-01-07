module 0x80cb35d78532b5cafc56b7a0393722ab4bb063f000efed1cd42bf8b32473fc12::suismas {
    struct SUISMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISMAS>(arg0, 9, b"Suismas", b"Father Suismas", b"Suismas is coming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/603caccf313e163919fdb62c9b64dc37blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISMAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


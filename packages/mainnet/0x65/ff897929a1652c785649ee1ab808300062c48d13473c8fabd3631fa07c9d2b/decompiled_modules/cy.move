module 0x65ff897929a1652c785649ee1ab808300062c48d13473c8fabd3631fa07c9d2b::cy {
    struct CY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CY>(arg0, 9, b"CY", b"Cloudy", b"Cloudy is a cheerful, fluffy cloud with a big smile and a sunny personality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1c62e076032d9f5db031aba937e9adeeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


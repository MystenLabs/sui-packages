module 0x1d6e0391f235175adbb6c993b0216877b4bf174050e0c93d3a98f67e48b9b7c4::dumd {
    struct DUMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMD>(arg0, 9, b"DUMD", b"Dummy Dog", b"Dog couldn't stop yapping so I dummied it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c21418a00e6aeffca9b793fdb14b24e8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUMD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


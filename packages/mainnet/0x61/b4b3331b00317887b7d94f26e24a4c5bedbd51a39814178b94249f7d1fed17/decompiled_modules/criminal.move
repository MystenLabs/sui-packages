module 0x61b4b3331b00317887b7d94f26e24a4c5bedbd51a39814178b94249f7d1fed17::criminal {
    struct CRIMINAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRIMINAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRIMINAL>(arg0, 9, b"Criminal", b"War criminal", x"576172206372696d696e616c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/32b0fe94925a688c103998d4d9fd47a4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRIMINAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRIMINAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


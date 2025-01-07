module 0x6b362d15fd76330c4114bb7bf38206544bfd1588be554391057fe5392969126c::oreo {
    struct OREO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OREO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OREO>(arg0, 9, b"Oreo", b"Oreo", b"Oreo es mi mascota y es adorable.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"0x817b9e5892abdf7e41b48e6940599cce862f3313e23cc70ecc366185df5cddd1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OREO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OREO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OREO>>(v1);
    }

    // decompiled from Move bytecode v6
}


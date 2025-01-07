module 0x6cf094392189519923fa2f296b6e2cfc2db3536d23e7d2fc57ce0839b2db8443::swater {
    struct SWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWATER>(arg0, 9, b"SWater", b"Sui Water", b"Sui Water !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/806850da1c1626be6c13a84ea762b1c9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWATER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWATER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


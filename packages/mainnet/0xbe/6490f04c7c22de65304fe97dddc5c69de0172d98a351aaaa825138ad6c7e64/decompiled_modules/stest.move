module 0xbe6490f04c7c22de65304fe97dddc5c69de0172d98a351aaaa825138ad6c7e64::stest {
    struct STEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEST>(arg0, 9, b"STEST", b"SUITEST", b"just a test.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://techsolids.com/wp-content/uploads/jet-form-builder/a40c98ea71314ca93a605b4e60a3b8f1/2024/09/prueba_logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STEST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEST>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xa98c54bd2d152c8c471a67ebaeaf2bd2e5ac31a5bd084e924841c51d91c67880::putin {
    struct PUTIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUTIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUTIN>(arg0, 9, b"PUTIN", b"PUTIN Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://image.baophapluat.vn/w840/Uploaded/2025/wpwfzyrslxj/2025_02_02/v-v-putin-3810-5270.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUTIN>(&mut v2, 1000000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUTIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PUTIN>>(v2);
    }

    // decompiled from Move bytecode v6
}


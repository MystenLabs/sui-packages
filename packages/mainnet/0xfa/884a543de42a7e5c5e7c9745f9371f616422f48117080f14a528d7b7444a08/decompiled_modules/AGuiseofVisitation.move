module 0xfa884a543de42a7e5c5e7c9745f9371f616422f48117080f14a528d7b7444a08::AGuiseofVisitation {
    struct AGUISEOFVISITATION has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGUISEOFVISITATION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGUISEOFVISITATION>(arg0, 0, b"COS", b"A Guise of Visitation", b"All roads lead to the Hearth... where none shall be recognized...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_A_Guise_of_Visitation.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGUISEOFVISITATION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGUISEOFVISITATION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


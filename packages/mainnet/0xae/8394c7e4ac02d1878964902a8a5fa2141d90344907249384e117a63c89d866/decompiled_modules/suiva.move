module 0xae8394c7e4ac02d1878964902a8a5fa2141d90344907249384e117a63c89d866::suiva {
    struct SUIVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVA>(arg0, 6, b"SUIVA", b"SUIVATAR", b"Suivatar , the mini avatar from Pandora ready for SUI world. Speak in Na'vi for better response. SUIVATAR is the mini avatar for the community, create a telegram for him or die. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mr_3_6735fb74dd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVA>>(v1);
    }

    // decompiled from Move bytecode v6
}


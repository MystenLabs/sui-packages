module 0x8f4de3ff42d434fb94b2f5449b534fec8e49396f58150c219d78ab1c95a6ac07::typus {
    struct TYPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYPUS>(arg0, 9, b"TYPUS", b"Typus Finance", b"Typus Finance is a real yield infrastructure on Sui Blockchain (Sui) that enables users to obtain superior risk-to-reward returns, all in one click.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/Typus_Finance_27291411a1.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYPUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TYPUS>>(0x2::coin::mint<TYPUS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TYPUS>>(v2);
    }

    // decompiled from Move bytecode v6
}


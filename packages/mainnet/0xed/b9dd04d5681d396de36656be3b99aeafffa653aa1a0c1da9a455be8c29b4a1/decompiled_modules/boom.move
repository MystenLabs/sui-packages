module 0xedb9dd04d5681d396de36656be3b99aeafffa653aa1a0c1da9a455be8c29b4a1::boom {
    struct BOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM>(arg0, 6, b"BOOM", b"Sui Boom", x"42454341524546554c4c21212053554920424f4d2043414e20424c4f572055502059414c4c210a53454e4420544f204849474820544f205341464520495421210a4b412d424f4f4f4f4f4f4f4d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_a622f6c7e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}


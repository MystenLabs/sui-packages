module 0x2b70ce6a3351d37c9eb9647890a887ba76bc1de36ad91d4107f68f84bee835b0::saids {
    struct SAIDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIDS>(arg0, 6, b"SAIDS", b"SUI Aids", b"SUI Aids is a dedicated platform aimed at supporting individuals living with AIDS and promoting the celebration of AIDS Day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_30_23_27_19_803fbcdd75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAIDS>>(v1);
    }

    // decompiled from Move bytecode v6
}


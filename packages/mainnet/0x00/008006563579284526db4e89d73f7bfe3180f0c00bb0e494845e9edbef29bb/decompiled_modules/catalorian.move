module 0x8006563579284526db4e89d73f7bfe3180f0c00bb0e494845e9edbef29bb::catalorian {
    struct CATALORIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATALORIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATALORIAN>(arg0, 6, b"CATALORIAN", b"TheOnlyCatalorian", b"So join us today and become a part of the Catalorian community. Together, we will build, grow, and prosper.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ffd0a3af_92be_46a3_9023_3235e72644fe_4f8bc91c01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATALORIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATALORIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}


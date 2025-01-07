module 0xacae73afc97ae33a744b2f798dcf3651fa073640e31d3f574a9196ddf688d1ae::fwogr {
    struct FWOGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOGR>(arg0, 6, b"FWOGR", b"Fwogtober", b"issa fwogtober type beat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_ZU_Lxas_AA_Ju_Zp_a63fc9e27c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOGR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOGR>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x6d0d777be78af44df81c07bf4b757853ac05cee0837e19b36fae73b376280e59::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOG>(arg0, 6, b"sDOG", b"sDOG on SUI", x"54686520646f67206b65657073207370696e6e696e672e20464f52455645522e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tkk_Kasmx_400x400_877bc79e90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}


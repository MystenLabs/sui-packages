module 0x38c5c10e6df5943b330b63480218955e27e29dbaaae229e6a724b0d28646830e::fapo {
    struct FAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAPO>(arg0, 6, b"FAPO", b"FATHER HIPPO", b"Meet FAPO, the legendary Father Hippo!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8w_FC_Vtgf_400x400_be3e02efcd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAPO>>(v1);
    }

    // decompiled from Move bytecode v6
}


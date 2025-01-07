module 0x8751bebfd73b813f42e159f4cdd534156b75eb7bcf553301e4c5a09360b4819e::rtrd {
    struct RTRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RTRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RTRD>(arg0, 6, b"RTRD", b"RETARDIO", b"RETADIO works so hard to make her name on TOP!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MC_a79513c57a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RTRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RTRD>>(v1);
    }

    // decompiled from Move bytecode v6
}


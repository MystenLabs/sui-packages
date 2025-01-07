module 0x63df5a2f1055a9442efae32e6963cfc031d3b6c8fac9b70488c713cc353562cd::fkg {
    struct FKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FKG>(arg0, 6, b"FKG", b"FUCKGAY", b"FUCKGAY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_It_D_5_Xk_AASRBP_dcb75f7f1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FKG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FKG>>(v1);
    }

    // decompiled from Move bytecode v6
}


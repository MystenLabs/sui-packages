module 0x111e1fc6feec01e5d92b7f5933cb73fd5619176a37a5361b1485c26409897d9f::suididdy {
    struct SUIDIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDIDDY>(arg0, 6, b"SUIDIDDY", b"DIDDY'S OIL", b"Authorities found 1000 bottles of baby oil in DIDDY's mansion kek!!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Nv_M_Rzv_Pk_400x400_00e87c30b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}


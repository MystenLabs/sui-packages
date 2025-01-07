module 0xed67d20c4e495331cf41a22d391c2f0d94a2b923b2b07c7c0a4ae88a6e7084b2::mkk {
    struct MKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKK>(arg0, 6, b"MKK", b"Monki king", b"The monki King ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6f_Kfvc_Gw_400x400_63eec16977.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MKK>>(v1);
    }

    // decompiled from Move bytecode v6
}


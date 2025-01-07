module 0x51e9a7886cad3069096d539ddf492d8d89dce8b443ad4d4000de4edd8eb876e3::getrich {
    struct GETRICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GETRICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GETRICH>(arg0, 6, b"GETRich", b"GETRICH", b"Get rich or die gambling", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_Fe1n_R78_400x400_98104aaf64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GETRICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GETRICH>>(v1);
    }

    // decompiled from Move bytecode v6
}


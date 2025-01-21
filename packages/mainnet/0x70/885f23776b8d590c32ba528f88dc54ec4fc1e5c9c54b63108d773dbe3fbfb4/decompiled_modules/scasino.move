module 0x70885f23776b8d590c32ba528f88dc54ec4fc1e5c9c54b63108d773dbe3fbfb4::scasino {
    struct SCASINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCASINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCASINO>(arg0, 6, b"SCASINO", b"Sui Casino", b"The First Casino on  SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ts_Spbel_B_400x400_d490607efb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCASINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCASINO>>(v1);
    }

    // decompiled from Move bytecode v6
}


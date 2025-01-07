module 0x758ba0e36348bc1f777f6c69c49c11b7678cb6e384322e72000a1e10eec47b71::delulu {
    struct DELULU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELULU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELULU>(arg0, 6, b"DELULU", b"buy delulu", b"BUY DELULU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/azd_OZ_Qd5_400x400_4490827435.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELULU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DELULU>>(v1);
    }

    // decompiled from Move bytecode v6
}


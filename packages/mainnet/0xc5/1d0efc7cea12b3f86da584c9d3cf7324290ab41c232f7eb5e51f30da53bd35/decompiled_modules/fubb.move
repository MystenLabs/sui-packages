module 0xc51d0efc7cea12b3f86da584c9d3cf7324290ab41c232f7eb5e51f30da53bd35::fubb {
    struct FUBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUBB>(arg0, 6, b"FUBB", b"First Fubb on Sui", b"First Fubb on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_33_fc194daa15.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUBB>>(v1);
    }

    // decompiled from Move bytecode v6
}


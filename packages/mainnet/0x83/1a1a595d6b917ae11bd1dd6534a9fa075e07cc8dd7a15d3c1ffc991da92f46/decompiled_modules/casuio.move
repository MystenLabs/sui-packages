module 0x831a1a595d6b917ae11bd1dd6534a9fa075e07cc8dd7a15d3c1ffc991da92f46::casuio {
    struct CASUIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASUIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASUIO>(arg0, 6, b"Casuio", b"Lucky Casuio", b"Lucky Casuio on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ZCASFSAFASF_bfd2b5a23d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASUIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASUIO>>(v1);
    }

    // decompiled from Move bytecode v6
}


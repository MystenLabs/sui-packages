module 0xaf2f1780760bb5d8414999c0c552f2a216d84c3ab8775205fab49053981b999f::hupo {
    struct HUPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUPO>(arg0, 6, b"Hupo", b"Hopo", b"letsgo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/final_be495df569.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUPO>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x4e6992fca40b9f6d38226f358f1c68731f7cb846930e54633dd75199690c7546::blf {
    struct BLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLF>(arg0, 6, b"BLF", b"BULL_FARMER", b"Bull run now for farmer.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/431382974_10226081862852439_7236427398847957370_n_f03cd96017.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLF>>(v1);
    }

    // decompiled from Move bytecode v6
}


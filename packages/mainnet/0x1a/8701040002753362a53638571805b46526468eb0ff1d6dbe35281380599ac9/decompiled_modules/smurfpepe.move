module 0x1a8701040002753362a53638571805b46526468eb0ff1d6dbe35281380599ac9::smurfpepe {
    struct SMURFPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURFPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURFPEPE>(arg0, 6, b"SmurfPepe", b"Smurf Pepe", b"SMURF PEPE come on suo now, big memecoin you need to buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sb_5fc0c567f2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURFPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURFPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}


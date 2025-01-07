module 0xe468f13a300335f623c66aca3930175fe41700591c92537bac417e62b2d9279b::pvp {
    struct PVP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PVP>(arg0, 6, b"PvP", b"forever PvP", x"4e6f7468696e6720696e206865726520646f6e74206275792069740a0a4a75737420796f752772652061206469636b2c207765206e657665722067726f77696e20666f726576657220507650206576657279776865726520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730992828161.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PVP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


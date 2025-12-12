module 0x96947d4297cd2a9c62c4577eec61dba7de6c4c34935d95ca40b00cdd598b1a47::pawtato_coin_raw_topaz {
    struct PAWTATO_COIN_RAW_TOPAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_RAW_TOPAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_RAW_TOPAZ>(arg0, 9, b"RAW_TOPAZ", b"Pawtato Raw Topaz", b"An uncut and unpolished Topaz, showing its natural shape and rough surface.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/topaz-raw.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_RAW_TOPAZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_RAW_TOPAZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_raw_topaz(arg0: 0x2::coin::Coin<PAWTATO_COIN_RAW_TOPAZ>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_RAW_TOPAZ>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}


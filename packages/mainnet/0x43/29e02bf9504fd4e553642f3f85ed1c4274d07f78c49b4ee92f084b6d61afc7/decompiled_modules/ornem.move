module 0x4329e02bf9504fd4e553642f3f85ed1c4274d07f78c49b4ee92f084b6d61afc7::ornem {
    struct ORNEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORNEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORNEM>(arg0, 6, b"ORNEM", b"purp", b"he", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732230630390.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORNEM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORNEM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


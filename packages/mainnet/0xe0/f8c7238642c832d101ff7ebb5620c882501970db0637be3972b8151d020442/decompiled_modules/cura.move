module 0xe0f8c7238642c832d101ff7ebb5620c882501970db0637be3972b8151d020442::cura {
    struct CURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CURA>(arg0, 6, b"CURA", b"Cute Rabbit on Sui", b"Hury up! Let's help this rabbit to explore crypto planet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CURA_c9a601e7ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CURA>>(v1);
    }

    // decompiled from Move bytecode v6
}


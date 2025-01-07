module 0xcd3f3f98f18b659820eafafdb9ed5bef6f9dbd8f8fbbf52306d59f2dab4f45fa::sump {
    struct SUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMP>(arg0, 6, b"SUMP", b"Seal Trump", b"Seal Trump the president seal, sealed the victory , prosperity to al HU RA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_dd_Hlx_Sp_C_1731735196277_512_e1d714ffdd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x809663afbee67fe68b02ba11f67c2c2303b230254850d4939d452e01de03fa41::doph {
    struct DOPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPH>(arg0, 6, b"DOPH", b"Doph", x"544845204f4e4c5920444f4c5048494e205357494d4d494e27204f4e20535549200a0a28536572696f75736c792c20636f6d652067657420796f757220646f7068616d696e6529", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731071402875.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOPH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


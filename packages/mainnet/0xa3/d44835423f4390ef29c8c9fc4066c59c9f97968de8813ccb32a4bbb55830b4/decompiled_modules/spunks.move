module 0xa3d44835423f4390ef29c8c9fc4066c59c9f97968de8813ccb32a4bbb55830b4::spunks {
    struct SPUNKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUNKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUNKS>(arg0, 6, b"SPUNKS", b"Sui punks", x"245350554e4b532069732061206d656d65636f696e206c61756e63686564206f6e0a74686520537569206e6574776f726b2c20696e737069726564206279207468650a69636f6e69632043727970746f50756e6b732e20417320612066756e20616e640a6c69676874686561727465642076657273696f6e206f66207468652066616d6f75730a4e465473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_35_21d6102cf4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUNKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUNKS>>(v1);
    }

    // decompiled from Move bytecode v6
}


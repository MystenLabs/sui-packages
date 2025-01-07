module 0x845aa69df4700e3f2487ddda824be7447b1bf9ec42fedf997178415dc8085a30::mcpepe {
    struct MCPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCPEPE>(arg0, 6, b"MCPEPE", b"SUI MCPEPE", x"4d4350455045204f4e20535549200a0a47657420726561647920666f72206120776869726c77696e64206f66206d61646e6573732c205765206e6f7720736572766520796f7520746865206d6f73742065706963206d656d65636f696e20696e207468652053756920436861696e21204372617a7920616e642066756e2067756172616e746565642120536f6f6e20506570652077696c6c2068617665206e6f206d6f72652074656172732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOVEPUMP_6adf5b418b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}


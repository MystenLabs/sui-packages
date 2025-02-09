module 0x127ef8a9f797bdcd209c20231194464f4a2d598c1a3c6f494491a159137c2e64::slomo {
    struct SLOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOMO>(arg0, 6, b"SLOMO", b"SloMo", x"4e6f20464f4d4f2c206e6f207374726573736a75737420736c6f7720616e6420737465616479206761696e732e205765206e617020686172646572207468616e2077652070756d702c20706c616e742074726565732c20616e64206275696c64206120636f6d6d756e6974792074686174206c617374732e0a0a204d656d657320262076696265730a204e61702d746f2d4561726e20636f6e636570740a20436861726974792d64726976656e20287965732c20776520706c616e74207472656573290a0a4a6f696e2074686520536c6f77706f63616c797073652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2148a2a5_22fc_44ee_8d72_da486739cc38_f68c370204.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}


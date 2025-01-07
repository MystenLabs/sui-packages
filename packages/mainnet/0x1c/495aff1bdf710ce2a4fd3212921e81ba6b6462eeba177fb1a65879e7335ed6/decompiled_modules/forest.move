module 0x1c495aff1bdf710ce2a4fd3212921e81ba6b6462eeba177fb1a65879e7335ed6::forest {
    struct FOREST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOREST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOREST>(arg0, 6, b"FOREST", b"FOREST ON SUI", x"24464f52455354206d656d65636f696e207370726f7574730a756e6578706563746564206469676974616c20736565646c696e670a0a69662069742067726f77732c206c6574206974207365727665206e61747572653a200a66756e64207265666f726573746174696f6e200a737570706f72742065636f73797374656d207265736561726368200a70726f7465637420656e64616e67657265642068616269746174730a0a747275652076616c7565206c696573206e6f7420696e2070726963650a62757420696e20706f73697469766520696d70616374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_Upt_ST_4q_400x400_f4edad2abc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOREST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOREST>>(v1);
    }

    // decompiled from Move bytecode v6
}


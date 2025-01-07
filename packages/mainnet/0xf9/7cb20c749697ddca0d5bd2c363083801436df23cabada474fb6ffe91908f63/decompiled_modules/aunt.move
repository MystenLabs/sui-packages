module 0xf97cb20c749697ddca0d5bd2c363083801436df23cabada474fb6ffe91908f63::aunt {
    struct AUNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUNT>(arg0, 6, b"AUNT", b"AUNT SUI", x"41554e5420697320616c7761797320666972737420696e206c696e6520746f2079656c6c2c2064656d616e6420726566756e64732c20616e642072656d696e6420796f75207468617420276261636b20696e20686572206461792c2720796f7520616e642063727970746f206469646e2774206578697374210a0a3078636234333533303730643731636630323566636237393663613065613434316365303438616634643538366131356231353364646234346234623535643763623a3a61756e743a3a41554e54", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734366917351.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUNT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUNT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


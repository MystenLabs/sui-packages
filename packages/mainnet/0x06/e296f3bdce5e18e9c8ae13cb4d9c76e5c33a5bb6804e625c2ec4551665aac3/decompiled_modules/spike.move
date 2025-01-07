module 0x6e296f3bdce5e18e9c8ae13cb4d9c76e5c33a5bb6804e625c2ec4551665aac3::spike {
    struct SPIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIKE>(arg0, 6, b"SPIKE", b"S P I K E", x"494d205350494b4521207468652066697273742064726177696e672063726561746564206279206d6174742066757269650a416e206f726967696e616c2063686172616374657220746861742063616d65206265666f726520506570652c20427265747420616e6420486f7070792e20447261776e20696e20313938342062792074686520476f64666174686572206f66206d656d65732c204d6174742046757269652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RP_Xpr_WLP_400x400_e9eb4ddeaa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}


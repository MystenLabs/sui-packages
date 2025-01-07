module 0xc0e9d2f60f9e4ab4b57383e6edf739409282980612627110c72e4e18d3fc378e::jj {
    struct JJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJ>(arg0, 6, b"JJ", b"JEJE", x"594f552756452041435455414c4c592050524f4241424c59204d45542048494d204245464f52452c20244a4a204953204f4e45204f4620544845204d4f535420574944454c592043495243554c4154454420454d4f4a4953204f4e20444953434f52442c20414e442048452753204b494e4441204355544520444f4e275420594f55205448494e4b3f20534f205745204445434944454420544f20474956452048494d20484953204f574e20544f4b454e2c20414e44204e414d452048494d20544f4f2e2e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_Lx_U_Mik_V_400x400_9888d54dea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JJ>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xf7a93086ee2c574a08e98854462abfb67035e89b54423b83070d1c8e6f7423b0::invtractor {
    struct INVTRACTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: INVTRACTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INVTRACTOR>(arg0, 6, b"INVTRACTOR", b"Invisible Tractor", x"496e76697369626c652054726163746f7220697320612066756e20616e6420756e69717565206d656d65636f696e0a666561747572696e672061206375746520646f672064726976696e6720616e20696e76697369626c652074726163746f722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_14_A_s_13_00_22_edc33434_04a0d49b38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INVTRACTOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INVTRACTOR>>(v1);
    }

    // decompiled from Move bytecode v6
}


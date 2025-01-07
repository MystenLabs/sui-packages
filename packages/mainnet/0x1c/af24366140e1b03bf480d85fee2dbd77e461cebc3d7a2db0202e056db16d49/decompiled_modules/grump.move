module 0x1caf24366140e1b03bf480d85fee2dbd77e461cebc3d7a2db0202e056db16d49::grump {
    struct GRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMP>(arg0, 6, b"GRUMP", b"SuiPuRR GRuMP", b"Unhappiness Maxi hold meee :(", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Grump_6a42daba64.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}


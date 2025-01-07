module 0x48b6a640cf6d322af26667c8e34aa5ce2c4ef29fbba2a4b20cbb6bfc060befbf::spc {
    struct SPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPC>(arg0, 6, b"SPC", b"SuiPlexCity", b"SuiPlex City Bitch ($SPC)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_I_de_ecran_din_2024_10_09_la_23_38_22_06a56920e5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPC>>(v1);
    }

    // decompiled from Move bytecode v6
}


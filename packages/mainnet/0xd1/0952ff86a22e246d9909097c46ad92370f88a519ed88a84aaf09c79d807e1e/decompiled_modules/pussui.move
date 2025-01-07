module 0xd10952ff86a22e246d9909097c46ad92370f88a519ed88a84aaf09c79d807e1e::pussui {
    struct PUSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSUI>(arg0, 6, b"PUSSUI", b"CAMEL TOE SUI", x"57656c636f6d6520746f2024505553535549202d2043616d656c20546f65205375692048512077686572652074696768742070616e747320616e64206e6f207368616d6520636f6c6c6964652e200a0a49747320626f6c642c2069742773206a756963792c20616e64206974277320737465616c696e67207468652073706f746c69676874206f6e65207365616d20617420612074696d652e200a0a496620796f75277265206e6f742073746172696e672c20796f75277265206c79696e672e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/camel_toe_gif_6d642d1981.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


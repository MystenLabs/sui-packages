module 0x2fc87651cef7fef47f391e9d9cc2ff6bfa193f5290950fc77d434ee705743266::nbs {
    struct NBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NBS>(arg0, 6, b"NBS", b"NekoBotAi Sui", x"4e454b4f424f542041493a204c656170696e6720696e746f2074686520667574757265206f66204149206f6e2074686520535549204e4554574f524b202e0a0a2057696c6c2074686973206879706564206d656d6520636f696e2068656c7020796f7520686f7020746f20726963686573206f72206c6561766520796f752063726f616b696e672e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_7_0ac899f913.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NBS>>(v1);
    }

    // decompiled from Move bytecode v6
}


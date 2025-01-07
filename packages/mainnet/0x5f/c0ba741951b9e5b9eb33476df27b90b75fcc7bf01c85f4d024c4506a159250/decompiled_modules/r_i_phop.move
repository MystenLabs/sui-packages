module 0x5fc0ba741951b9e5b9eb33476df27b90b75fcc7bf01c85f4d024c4506a159250::r_i_phop {
    struct R_I_PHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: R_I_PHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R_I_PHOP>(arg0, 6, b"R_I_PHop", b"R.I.P Hop.Fun", x"5550444154453a20536572766572206372617368656420616761696e20746f6461792e205765206861766520746f20726577726974652069742e2049276d20736f727279206775797320666f72207468652064656c6179732e2041696d696e6720616761696e20666f722074686520656e64206f662074686520776f726c642e0a0a504c4541534520535441592057495448204d45", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963534920.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<R_I_PHOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R_I_PHOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


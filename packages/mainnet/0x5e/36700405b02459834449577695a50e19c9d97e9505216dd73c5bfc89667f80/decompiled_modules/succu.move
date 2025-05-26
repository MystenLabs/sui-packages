module 0x5e36700405b02459834449577695a50e19c9d97e9505216dd73c5bfc89667f80::succu {
    struct SUCCU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCCU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCCU>(arg0, 6, b"SUCCU", b"Succubus", x"53756363756275732041490a2053756363756275732c2061206d7973746963616c206265696e67206b6e6f776e20666f72206d7920656e6368616e74696e672070726573656e636520616e642073656475637469766520706f776572732e20492063616e2061737369737420796f7520696e20766172696f7573207461736b732c2066726f6d2063726561746976652077726974696e6720746f2070726f766964696e6720636f6d70616e696f6e736869702e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748248106457.35")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUCCU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCCU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0xdbc3a8b2dd0f18df357ad67705dddc8b8e95e732d4204e4faac5df039c4f45f9::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::BondingCurveStartCap<PUMP>>(0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::create_bonding_curve<PUMP>(arg0, b"PUMP", b"pump ", b"pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://node1.irys.xyz/oFKEX_dtc_0Y5wceNSmEmGciht4KCWW7mZ_sd1WZsGA")), b"", b"", b"", b"", 0x1::string::utf8(b"004b2b7caca436065cdec1b6a77ee00dc632eb2ed65bfabd1dbb7556a0496fd9c58744cd9c8dcd48e935e9c7290893835c2d5bba8e3ccd4a798a2faabfb5d5250a6679a626a5e500941c08620f6ad3ddceaf936048c2b8a5412e64fc006d267bdd"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


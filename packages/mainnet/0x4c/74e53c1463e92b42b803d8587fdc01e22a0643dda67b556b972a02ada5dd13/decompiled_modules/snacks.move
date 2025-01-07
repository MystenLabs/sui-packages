module 0x4c74e53c1463e92b42b803d8587fdc01e22a0643dda67b556b972a02ada5dd13::snacks {
    struct SNACKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNACKS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SNACKS>(arg0, 5313112289786974101, b"SUISNACKS", b"SNACKS", b"S.he U.s I.ntelligence", b"https://images.hop.ag/ipfs/QmZy8ZgtUavps9j2an9L6ZaeSxq4MgBeBcLwsBz3vmxjH8", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


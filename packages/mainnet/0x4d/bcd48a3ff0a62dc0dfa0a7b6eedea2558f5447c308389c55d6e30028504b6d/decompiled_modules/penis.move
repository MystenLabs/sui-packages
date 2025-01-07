module 0x4dbcd48a3ff0a62dc0dfa0a7b6eedea2558f5447c308389c55d6e30028504b6d::penis {
    struct PENIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENIS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<PENIS>(arg0, 8962175137729946843, b"PENIS", b"PENIS", b"Avarage penis", b"https://images.hop.ag/ipfs/QmfWk4XkiuK9rGT9uu4WW7Cr5Wp9GcYZ1jWKXkxsWVc52F", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


module 0xa84b35b82fc760700f2c9d5a7ea7969e6d4abaaa0fdb5d917d7f783f6451e5c4::tlp {
    struct TLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TLP>(arg0, 9, 0x1::string::utf8(b"TLP"), 0x1::string::utf8(b"Typus Perp LP Token Main Pool"), 0x1::string::utf8(b"Typus Perp LP Token for Main Pool"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Typus-Lab/typus-asset/main/assets/TLP.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TLP>>(0x2::coin_registry::finalize<TLP>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TLP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


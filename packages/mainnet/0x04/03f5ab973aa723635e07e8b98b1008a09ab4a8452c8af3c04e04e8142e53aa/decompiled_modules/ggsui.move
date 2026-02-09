module 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::ggsui {
    struct GGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GGSUI>(arg0, 9, 0x1::string::utf8(b"ggSUI"), 0x1::string::utf8(b"ggSUI"), 0x1::string::utf8(x"4c6971756964207374616b65642053554920627920486f6e6579506c61792e205374616b65205355492c207265636569766520676753554920e28094206561726e207374616b696e67207265776172647320706c75732061207368617265206f66206d61726b6574706c6163652074726164696e6720666565732e2046756c6c79206c69717569642c2066756c6c7920636f6d706f7361626c652e"), 0x1::string::utf8(b"https://assets.honeyplay.fun/coins/ggsui.png"), arg1);
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<GGSUI>>(0x2::coin_registry::finalize<GGSUI>(v0, arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


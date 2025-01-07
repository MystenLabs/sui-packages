module 0x5f09cf368d695f012ce78a1309494a4916815a8ffe12771295603a63c70bbea7::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<IUS>(arg0, 11348115351299586650, b"ius", b"IUS", b"IUS", b"https://images.hop.ag/ipfs/Qmb5b8RHyyfZciwWh4bgMKJfh2dwsUndLZ4vFL72H1EaAM", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


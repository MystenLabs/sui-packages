module 0x231fc107cfa039b87949a26886de3c9fc3ce1c2d7d800dcd78f2c00e0501b4e8::nww {
    struct NWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWW, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<NWW>(arg0, 1040818790190848202, b"NO WORLD WAR III", b"$NWW", x"4a6f696e20746865206d6f76656d656e7420746f2073746f702057572049494920746f646179c2a0636861647321", b"https://images.hop.ag/ipfs/QmNtfgPbRxh7HVmDTEoD4hd2DFZMRnSVyKDqo98geCnyrz", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/NWWIIICTO"), arg1);
    }

    // decompiled from Move bytecode v6
}


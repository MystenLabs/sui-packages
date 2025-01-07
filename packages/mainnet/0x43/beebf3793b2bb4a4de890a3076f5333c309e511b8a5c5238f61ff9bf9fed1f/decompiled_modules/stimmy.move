module 0x43beebf3793b2bb4a4de890a3076f5333c309e511b8a5c5238f61ff9bf9fed1f::stimmy {
    struct STIMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STIMMY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<STIMMY>(arg0, 9324392192754681817, b"Sui Tokenized Incentive Model for Monetary Yield", b"STIMMY", b"Due to current market conditions I now identify as a stimulus package.", b"https://images.hop.ag/ipfs/QmQvAXXrH5p78Nzt87Pkne5tu4arVdRYNZhRcCLb676ZsH", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


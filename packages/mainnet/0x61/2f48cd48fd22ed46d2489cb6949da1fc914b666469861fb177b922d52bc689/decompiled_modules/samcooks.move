module 0x612f48cd48fd22ed46d2489cb6949da1fc914b666469861fb177b922d52bc689::samcooks {
    struct SAMCOOKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMCOOKS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SAMCOOKS>(arg0, 10163076310090311945, b"SamCookie", b"SAMCOOKS", b"The coin that will put the man's legacy back where it belongs.", b"https://images.hop.ag/ipfs/Qma8kftGf8uELqLVEyvMBBii6Zqqa6dR7BzXw1SyL5N4ED", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


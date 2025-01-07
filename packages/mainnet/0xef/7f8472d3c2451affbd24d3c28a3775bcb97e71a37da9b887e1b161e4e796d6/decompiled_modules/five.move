module 0xef7f8472d3c2451affbd24d3c28a3775bcb97e71a37da9b887e1b161e4e796d6::five {
    struct FIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIVE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<FIVE>(arg0, 12017144590289078543, b"minus5", b"five", b"-5", b"https://images.hop.ag/ipfs/QmUXzJi8wkJSCQPE3xfzeu9dfdeat2AYe2rLurWczhGxzP", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}


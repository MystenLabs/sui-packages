module 0xf15dcc295ce6ca303f1a05954e9bc7cef4a73dbe18bf6ed3c841e231d46ab2b5::xaum {
    struct XAUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAUM, arg1: &mut 0x2::tx_context::TxContext) {
        0x737f6c4d8ed4186915be61186cd332bd713f849271a73062c4230c8e5e5f60d1::mtoken::create_coin<XAUM>(arg0, 9, b"XAUM", b"Matrixdock Gold", b"Matrixdock Gold (XAUm) is a standardized token deployed on multiple chains, with a 1:1 peg to 1 troy oz. fine weight of high grade LBMA gold. The total supply of XAUm will always be equal to the amount of underlying assets stored in highly secured and reputable vaults.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.matrixdock.com/images/xaum/xaum-64x64-icon.png")), true, 0, arg1);
    }

    // decompiled from Move bytecode v6
}


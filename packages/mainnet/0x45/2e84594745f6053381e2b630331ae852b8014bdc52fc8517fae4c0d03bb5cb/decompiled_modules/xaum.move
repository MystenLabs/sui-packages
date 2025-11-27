module 0x452e84594745f6053381e2b630331ae852b8014bdc52fc8517fae4c0d03bb5cb::xaum {
    struct XAUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAUM, arg1: &mut 0x2::tx_context::TxContext) {
        0x1e668ba476bfb496a96f7e957414c27db08866224ca183b806272ed81dff6122::mtoken::create_coin<XAUM>(arg0, 9, b"XAUM", b"Matrixdock Gold", b"Matrixdock Gold (XAUm) is a standardized token deployed on multiple chains, with a 1:1 peg to 1 troy oz. fine weight of high grade LBMA gold. The total supply of XAUm will always be equal to the amount of underlying assets stored in highly secured and reputable vaults.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.matrixdock.com/images/xaum/xaum-64x64-icon.png")), true, 0, arg1);
    }

    // decompiled from Move bytecode v6
}


module 0x49fb793b13eb3343f671836e031d575e25c69c48a925ede9a214d601cf5949f9::xaum {
    struct XAUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAUM, arg1: &mut 0x2::tx_context::TxContext) {
        0x57020589a3486b8e5a70f82746205b31b3c94358f03086ef8623231fb04a36ef::mtoken::create_coin<XAUM>(arg0, 9, b"XAUM", b"Matrixdock Gold", b"Matrixdock Gold (XAUm) is a standardized token deployed on multiple chains, with a 1:1 peg to 1 troy oz. fine weight of high grade LBMA gold. The total supply of XAUm will always be equal to the amount of underlying assets stored in highly secured and reputable vaults.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.matrixdock.com/images/xaum/xaum-64x64-icon.png")), true, 0, arg1);
    }

    // decompiled from Move bytecode v6
}


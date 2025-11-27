module 0xcace18256d2cb04f2e473138dca21e091c196ff484b40e99322ec298ef6871ba::xaum {
    struct XAUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAUM, arg1: &mut 0x2::tx_context::TxContext) {
        0x50c36ac5643f2a15f1fcbb4d01975758855c4f223d1fa80db7a56bec03050786::mtoken::create_coin<XAUM>(arg0, 9, b"XAUM", b"Matrixdock Gold", b"Matrixdock Gold (XAUm) is a standardized token deployed on multiple chains, with a 1:1 peg to 1 troy oz. fine weight of high grade LBMA gold. The total supply of XAUm will always be equal to the amount of underlying assets stored in highly secured and reputable vaults.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.matrixdock.com/images/xaum/xaum-64x64-icon.png")), true, 0, arg1);
    }

    // decompiled from Move bytecode v6
}


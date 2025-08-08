module 0xb2e1fd9dd505dddcb8f50b38197d29e714d6ab13e6eeabbbe826b74f185ad179::xaum {
    struct XAUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAUM, arg1: &mut 0x2::tx_context::TxContext) {
        0xe7e7803b452735ceea848a1cbb36f5aa279443729d9db9e27e65d116e5191a2a::mtoken::create_coin<XAUM>(arg0, 9, b"XAUM", b"Matrixdock Gold", b"Matrixdock Gold (XAUm) is a standardized token deployed on multiple chains, with a 1:1 peg to 1 troy oz. fine weight of high grade LBMA gold. The total supply of XAUm will always be equal to the amount of underlying assets stored in highly secured and reputable vaults.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.matrixdock.com/images/xaum/xaum-64x64-icon.png")), true, 0, arg1);
    }

    // decompiled from Move bytecode v6
}


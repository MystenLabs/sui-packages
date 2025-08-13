module 0xf68ad8d60b7896872d91549039dd3360aa36da3a08c6af091e323c7eb7dfb216::dtrwa {
    struct DTRWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTRWA, arg1: &mut 0x2::tx_context::TxContext) {
        0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::setup::setup<DTRWA>(arg0, 6, b"DTRWA", b"DT RWA MMF Token", b"{\"description\":{\"Introduction\":\"Investment objective: The USD Liquidity LVNAV Fund seeks to achieve a return in the Reference Currency in line with prevailing money market rates whilst aiming to preserve capital consistent with such rates and to maintain a high degree of liquidity.\"}}", b"https://bafybeiaady5ccavpgfqr27kzv7b7ybesoez3hr6nncog4szj7wsvryctlq.ipfs.dweb.link/", b"USD", 10000000000000, 1000000, arg1);
    }

    // decompiled from Move bytecode v6
}


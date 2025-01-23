module 0x9d7857e2db918b54fe68fcc29d29507a798bd82436241532fcd717d90ed9360e::stnk {
    struct STNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STNK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<STNK>(arg0, 6, b"STNK", b"STONK COIN  by SuiAI", b"The first memecoin deployed on SUI. .Backed by the IP to the meme..Stonks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/X2_Twitter_com_Gd5i3_GU_Xg_AA_8tlv_gif_c478465e0f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STNK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STNK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}


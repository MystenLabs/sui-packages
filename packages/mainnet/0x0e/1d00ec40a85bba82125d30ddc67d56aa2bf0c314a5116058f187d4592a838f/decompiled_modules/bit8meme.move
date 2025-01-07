module 0xe1d00ec40a85bba82125d30ddc67d56aa2bf0c314a5116058f187d4592a838f::bit8meme {
    struct BIT8MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIT8MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIT8MEME>(arg0, 6, b"BIT8MEME", b"Bit8Meme", b"I Choose MEME Everytime now shines on Sui with her own token, attracting crypto investors looking for the next mooncoin sensation. This $BIT8MEME token captures the crypto community's excitement and promises to be a unique investment, blending social media popularity with financial innovation. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_X8j_L4_L_We_DW_7j_SK_9q8xy4yg_Xa53uf_Cwq3_Nj_Fvk_Rc2dn_X_2b74478c20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIT8MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIT8MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}


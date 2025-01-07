module 0x6298b5a36fc97cad2a1f0e4da855d93e11356ec612c735d75fa86fd7268fa8f5::bbets {
    struct BBETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBETS>(arg0, 6, b"BBets", b"BonkBets", b" THE $BBETS meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_Za8_Gh_VPB_3_Pfy_Ec_J_Vmtp38_KV_73_TXQ_Xjxz_MR_Zwo_Z_Ps2_Jy_6502a0087e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBETS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBETS>>(v1);
    }

    // decompiled from Move bytecode v6
}


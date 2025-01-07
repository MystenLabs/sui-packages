module 0x2db04fa31afc30b67a0d833595c66e00d626e24280f48f10163f5b827f92a4f7::realsuiinu {
    struct REALSUIINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALSUIINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALSUIINU>(arg0, 6, b"Realsuiinu", b"SuiInuCTO", b"sui inus DEV is a liar, he bought 76% of the coins, I waited for several hours, but what I got was a scam, I believe I am not the only one who was deceived, now I want to build a community, I only hold a small part of the coins, the rest will be purchased by you, it will be completely led by the community members, boycott sui inu, we are the real sui inu!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K3_HE_Jo_X5_400x400_a5b1a951be_a_ae_00f2891a2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALSUIINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REALSUIINU>>(v1);
    }

    // decompiled from Move bytecode v6
}


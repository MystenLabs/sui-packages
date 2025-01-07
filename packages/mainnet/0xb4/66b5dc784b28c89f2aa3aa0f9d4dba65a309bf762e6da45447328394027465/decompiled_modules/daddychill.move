module 0xb466b5dc784b28c89f2aa3aa0f9d4dba65a309bf762e6da45447328394027465::daddychill {
    struct DADDYCHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADDYCHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADDYCHILL>(arg0, 6, b"DaddyChill", b"Daddy Chill", b"Daddy Chill is a meme that gained traction on Tiktok in mid-2020 where users began to imitate Tippy's delivery of the phrase in various funny scenarios. Notable TikTok videos have garned millions of views, showcasing its versatility and humor. Its catchy and relatable nature allows it to be easily adapted into different contexts, making it a favorite among users who enjoy playful banter. When price goes up, we say Daddy Chill.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_Pf_Yrsmio_ST_7_R2pd_B_Lf_T_Wi9f1gmgrt_D_Av_J_Jn_Un_M_Wpump_9541a0ca75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADDYCHILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADDYCHILL>>(v1);
    }

    // decompiled from Move bytecode v6
}


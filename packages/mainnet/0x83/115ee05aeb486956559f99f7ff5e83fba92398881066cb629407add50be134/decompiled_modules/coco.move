module 0x83115ee05aeb486956559f99f7ff5e83fba92398881066cb629407add50be134::coco {
    struct COCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCO>(arg0, 6, b"COCO", b"The Croc Chompin' on Sui", b"COCO, the brainchild of some seriously creative folks, brought the iconic croc meme to Solana. A toothy, chillin with a snaggle-toothed grin crocodile is ready to unleash a whole lot of meme-magic on the scene.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_EBSA_Dtn_JN_Xiwr_Bsv_J1_Lm5_HS_Yf2yh_Xz8_VRD_Xfruz_Rqhu_9a6235846e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCO>>(v1);
    }

    // decompiled from Move bytecode v6
}


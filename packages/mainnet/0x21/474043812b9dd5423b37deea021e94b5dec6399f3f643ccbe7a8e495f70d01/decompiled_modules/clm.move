module 0x21474043812b9dd5423b37deea021e94b5dec6399f3f643ccbe7a8e495f70d01::clm {
    struct CLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLM>(arg0, 6, b"CLM", b"Cat AI Agent Language Model", b"Cat AI Agent Language Model is an intelligent AI agent designed to assist, adapt, and make your tasks easier with seamless efficiency and a user-friendly approach.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmahrt4_Z_Ai_EHJPMV_3diz_Rx9_Tch_Jfrcdxuy89ks_S3_Gzu_PBQ_a62756e22a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLM>>(v1);
    }

    // decompiled from Move bytecode v6
}


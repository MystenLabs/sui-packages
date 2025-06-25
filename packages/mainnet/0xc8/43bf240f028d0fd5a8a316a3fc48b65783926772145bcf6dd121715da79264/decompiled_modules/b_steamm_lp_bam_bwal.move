module 0xc843bf240f028d0fd5a8a316a3fc48b65783926772145bcf6dd121715da79264::b_steamm_lp_bam_bwal {
    struct B_STEAMM_LP_BAM_BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_STEAMM_LP_BAM_BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_STEAMM_LP_BAM_BWAL>(arg0, 9, b"bSTEAMM LP bAM-bWAL", b"bToken STEAMM LP bAM-bWAL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_STEAMM_LP_BAM_BWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_STEAMM_LP_BAM_BWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}


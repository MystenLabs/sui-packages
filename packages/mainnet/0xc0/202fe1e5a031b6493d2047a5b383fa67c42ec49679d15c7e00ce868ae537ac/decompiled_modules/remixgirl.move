module 0xc0202fe1e5a031b6493d2047a5b383fa67c42ec49679d15c7e00ce868ae537ac::remixgirl {
    struct REMIXGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMIXGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMIXGIRL>(arg0, 6, b"REMIXGIRL", b"REMIX GIRL on SUI", x"52454d4958204749524c206f6e205355490a4c65742066636b696e672044616e63656565656565", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/artworks_I64_Vw_Y3_E654l3ymz_8s_Mf9w_t500x500_795368440f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMIXGIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REMIXGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}


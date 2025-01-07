module 0x4342b177e2e496d95f25418b3c6e65b0725344a985e8a97b361c161c8bd408ea::adam {
    struct ADAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAM>(arg0, 6, b"ADAM", b"ADAM BUNNY", b"$ADAM the blue rabbit, is ready to turn up the chaos on Sui. The money printer is a maniac! BRRRRRR adambunny.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_3u_Hbo_XQAAD_Kl_fab8362fb5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADAM>>(v1);
    }

    // decompiled from Move bytecode v6
}


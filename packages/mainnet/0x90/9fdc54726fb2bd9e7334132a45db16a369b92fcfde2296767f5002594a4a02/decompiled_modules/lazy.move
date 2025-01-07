module 0x909fdc54726fb2bd9e7334132a45db16a369b92fcfde2296767f5002594a4a02::lazy {
    struct LAZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAZY>(arg0, 6, b"LAZY", b"Lazy Sui Sloth", b"Hi, Im Lazy, the master of relaxation and champion of taking it slow. Lifes too short to rushwhy not hang around, savor the moment, and enjoy the view? Join me as I spread chill vibes and remind everyone that sometimes, the best pace is your own. Lets take it easy on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_T5u_DD_Fd_Lig_Kdn_ZCQVSH_Ev5i6_A_Vgx_Xfp3y7az_AD_Ppump_32b3a5e317.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAZY>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xf6840229f0cbd8b8bf621eabcddf4fe5f9956178036e67bfb9ed89f8eea9ee60::achisui {
    struct ACHISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACHISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACHISUI>(arg0, 6, b"Achisui", b"Achisui the Original Dog $WIF in the Sui Network", b"$ACHI the dog behind @dogwifcoin $WIF in the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GPEQ_8_Co_XMAE_Qih_d09e26cb11.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACHISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACHISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


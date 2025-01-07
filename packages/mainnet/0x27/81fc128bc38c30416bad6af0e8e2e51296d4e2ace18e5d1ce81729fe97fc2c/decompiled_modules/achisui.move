module 0x2781fc128bc38c30416bad6af0e8e2e51296d4e2ace18e5d1ce81729fe97fc2c::achisui {
    struct ACHISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACHISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACHISUI>(arg0, 6, b"Achisui", b"Achisui (The original Dog wif hat", b"$ACHI the dog behind  @dogwifcoin $WIF in the Sui Network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GPEQ_8_Co_XMAE_Qih_0238553b75.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACHISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACHISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


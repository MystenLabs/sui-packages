module 0x18a40f1a4faec97fc5507578e608a07658fd48edfd9f3c7501a955899beaae69::mawc {
    struct MAWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAWC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAWC>(arg0, 6, b"MAWC", b"MAGAWINCAT", b"Magawincat is an innovative token inspired by Donald Trump and his iconic Make America Great Again (MAGA) campaign. Our mission is to bring together Trump supporters and cat lovers, creating a fun and engaging community. $MAWC token holders can benefit from unique rewards, community events, and exclusive digital collectibles.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_Sggu_S57_400x400_e3d395d32f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAWC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAWC>>(v1);
    }

    // decompiled from Move bytecode v6
}


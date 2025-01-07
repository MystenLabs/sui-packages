module 0x2f706f75a5019546703085279f3064dc2ef0b5d68aa8935ee2000d9a33f4a7f7::cheeks {
    struct CHEEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEKS>(arg0, 6, b"CHEEKS", b"CHEEKSTOKEN", b"The leader of all Memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/srn_Mc_T_Ca_400x400_049085050d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEEKS>>(v1);
    }

    // decompiled from Move bytecode v6
}


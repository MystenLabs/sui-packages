module 0x9c70f6261fc31ae5f8e3dd5a64ae98aa868b40b7b700bf300b0159845cb9ea2::oscar {
    struct OSCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSCAR>(arg0, 6, b"OSCAR", b"OSCAR Token On Sui", b"Born from Ryoshi's iconic medium article for SHIB, $OSCAR is not just another meme token. It is the origin of the SHIB meme ecosystem itself", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/66ffd049526d3bdeb9eb57c1_logo_281c78186f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}


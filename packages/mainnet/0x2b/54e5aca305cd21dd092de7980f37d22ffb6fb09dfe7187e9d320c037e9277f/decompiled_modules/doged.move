module 0x2b54e5aca305cd21dd092de7980f37d22ffb6fb09dfe7187e9d320c037e9277f::doged {
    struct DOGED has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGED>(arg0, 6, b"DOGED", b"Doge Designer", b"Doge Designer $DOGED Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_Plh_dl_Y_400x400_eb391c56df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGED>>(v1);
    }

    // decompiled from Move bytecode v6
}


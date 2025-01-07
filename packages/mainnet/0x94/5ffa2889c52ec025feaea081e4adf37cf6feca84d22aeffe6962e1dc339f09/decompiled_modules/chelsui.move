module 0x945ffa2889c52ec025feaea081e4adf37cf6feca84d22aeffe6962e1dc339f09::chelsui {
    struct CHELSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHELSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHELSUI>(arg0, 6, b"CHELSUI", b"chelsui", b"When you realize $Chelsui is just a meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chelase_0be96e579c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHELSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHELSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


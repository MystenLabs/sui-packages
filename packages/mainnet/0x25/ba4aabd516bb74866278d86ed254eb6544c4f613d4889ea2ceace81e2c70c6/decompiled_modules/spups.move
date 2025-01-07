module 0x25ba4aabd516bb74866278d86ed254eb6544c4f613d4889ea2ceace81e2c70c6::spups {
    struct SPUPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUPS>(arg0, 6, b"SPUPS", b"SuiPups", b"sui pups meme token for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000089091_bfdb1af42d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUPS>>(v1);
    }

    // decompiled from Move bytecode v6
}


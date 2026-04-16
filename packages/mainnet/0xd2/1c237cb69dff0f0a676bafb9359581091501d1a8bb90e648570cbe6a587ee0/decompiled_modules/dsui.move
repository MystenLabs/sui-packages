module 0xd21c237cb69dff0f0a676bafb9359581091501d1a8bb90e648570cbe6a587ee0::dsui {
    struct DSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776348669982-256ec091f2c8e6137706de33acb6539d.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776348669982-256ec091f2c8e6137706de33acb6539d.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<DSUI>(arg0, 9, b"DSUI", b"Diamound SUI", b"the diamound of sui", v1, arg1);
        let v4 = v2;
        if (10000000000000000 > 0) {
            0x2::coin::mint_and_transfer<DSUI>(&mut v4, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSUI>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DSUI>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


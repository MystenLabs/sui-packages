module 0x22261e7cc7c75c3b5cfeb4595497a17c855e970b992fb1e3e5b5aa588a3916a9::sag {
    struct SAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAG>(arg0, 6, b"SAG", b"SAGITTARIUS", b"$SAG is a meme token that will achieve the impossible alongside its other siblings.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SAG_dd7f402f1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAG>>(v1);
    }

    // decompiled from Move bytecode v6
}


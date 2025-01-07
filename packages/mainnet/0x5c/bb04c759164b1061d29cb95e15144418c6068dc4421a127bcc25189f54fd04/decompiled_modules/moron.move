module 0x5cbb04c759164b1061d29cb95e15144418c6068dc4421a127bcc25189f54fd04::moron {
    struct MORON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORON>(arg0, 6, b"MORON", b"lightcrypto is a MORON", b"based on his recent tweet. lightcrypto is a moron", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lightcrypto_686200d748.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORON>>(v1);
    }

    // decompiled from Move bytecode v6
}


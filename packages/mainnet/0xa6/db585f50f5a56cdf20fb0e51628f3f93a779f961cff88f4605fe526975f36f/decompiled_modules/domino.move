module 0xa6db585f50f5a56cdf20fb0e51628f3f93a779f961cff88f4605fe526975f36f::domino {
    struct DOMINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOMINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOMINO>(arg0, 6, b"DOMINO", b"Domino", b"$DOMINO is a blockchain-based utility token designed to support and enhance the development, deployment,and maintenance of Telegram bots.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_Xa_C37d_N_400x400_01536831f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOMINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOMINO>>(v1);
    }

    // decompiled from Move bytecode v6
}


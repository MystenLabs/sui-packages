module 0x453a20342212476ae9e11bf1ae562de649be37a97bb082ff9624f20ea40d10bc::hemp {
    struct HEMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEMP>(arg0, 6, b"Hemp", b"Hemp Coin", b"Hemp is memecoin dedicated to raising awareness and promoting the sustainble cultivation and utilization of industrial hemp.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hemp_logo_1_1_97815daebc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEMP>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x4ef7ac9b95b3d1dd3ee1f993f4ffea1f7985c95308e4064e60295f5915e0fe9b::ltf {
    struct LTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTF>(arg0, 6, b"LTF", b"Low taper fade", b"This coin is going to be massive you know what else is massive Looowwwwww taper fadddeeeee ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733307214881.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LTF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


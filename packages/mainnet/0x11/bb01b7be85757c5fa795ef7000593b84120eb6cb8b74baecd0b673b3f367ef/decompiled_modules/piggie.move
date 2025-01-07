module 0x11bb01b7be85757c5fa795ef7000593b84120eb6cb8b74baecd0b673b3f367ef::piggie {
    struct PIGGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGGIE>(arg0, 6, b"PIGGIE", b"piggie", b"Our team welcomes you!!! We are successfully starting the Piggy project after long and difficult work. At your service is a project that in the world of tokens will allow you to accumulate and receive interest from all known platforms.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20240915014439_4a8a817ed7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}


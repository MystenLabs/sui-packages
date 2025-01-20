module 0x2dcf3c4c9e2d3cce6bbd6e71c01bb128204d02750168b336eaf33f3ed2281f9e::dogetrump {
    struct DOGETRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGETRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGETRUMP>(arg0, 6, b"DOGETRUMP", b"Dogetrump", b"After $trump was launched and made a big splash in the Blockchain ecosystem, now is the time for $Dogetrump to rise to follow in $trump's footsteps.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000045489_d4998814a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGETRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGETRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}


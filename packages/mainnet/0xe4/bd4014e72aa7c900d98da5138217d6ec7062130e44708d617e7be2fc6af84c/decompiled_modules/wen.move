module 0xe4bd4014e72aa7c900d98da5138217d6ec7062130e44708d617e7be2fc6af84c::wen {
    struct WEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEN>(arg0, 6, b"WEN", b"WENcoin", b"$Wen was built to triumph Time will tell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_de92b622a1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEN>>(v1);
    }

    // decompiled from Move bytecode v6
}


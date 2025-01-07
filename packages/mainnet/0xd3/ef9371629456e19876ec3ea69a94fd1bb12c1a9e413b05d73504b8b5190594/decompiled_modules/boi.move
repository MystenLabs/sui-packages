module 0xd3ef9371629456e19876ec3ea69a94fd1bb12c1a9e413b05d73504b8b5190594::boi {
    struct BOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOI>(arg0, 6, b"BOI", b"BOI ON SUI", b"Launching on sui soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018348_183dedab45.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOI>>(v1);
    }

    // decompiled from Move bytecode v6
}


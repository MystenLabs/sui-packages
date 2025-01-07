module 0x452dc0bc370cea49cee687160ff15551fdd8d274bff6a1c322d64a42eb7e457d::choctopus {
    struct CHOCTOPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOCTOPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOCTOPUS>(arg0, 6, b"CHOCTOPUS", b"Sui Choctopus", b"The goddest  boy on 12 legs! Half chocolate lab, half octopus and he only know 3 words, good, ball and moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016054_d52e3cf49a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOCTOPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOCTOPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}


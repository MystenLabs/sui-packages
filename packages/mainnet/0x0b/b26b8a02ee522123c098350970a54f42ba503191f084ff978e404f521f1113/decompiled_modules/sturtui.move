module 0xbb26b8a02ee522123c098350970a54f42ba503191f084ff978e404f521f1113::sturtui {
    struct STURTUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STURTUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STURTUI>(arg0, 6, b"STurtui", b"Sui Turti", x"2253756920547572746c653a20546865206d656d6520636f696e206f6620537569204e6574776f726b2120536c6f772c207374656164792c20616e642066756e20206a6f696e20746865207368656c6c20737175616420616e642072696465207468652053756920776176652e20457665727920747572746c6520686173206974732064617921220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_07_213048_dbe0d0f849.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STURTUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STURTUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


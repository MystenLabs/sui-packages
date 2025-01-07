module 0xdc9a7c1b4b0a604a503a85fd40d1ab003b504e28dad8cc6fe0614324f9653d6e::wa {
    struct WA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WA>(arg0, 6, b"Wa", b"Wa Seal", x"5365616c2073617973207761612c2077612c207761682c207768612c20776861612c206161682c20776161610a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/WA_logo_cfe27ad83e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WA>>(v1);
    }

    // decompiled from Move bytecode v6
}


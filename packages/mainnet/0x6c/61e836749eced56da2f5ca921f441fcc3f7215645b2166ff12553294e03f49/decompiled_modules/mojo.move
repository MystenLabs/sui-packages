module 0x6c61e836749eced56da2f5ca921f441fcc3f7215645b2166ff12553294e03f49::mojo {
    struct MOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJO>(arg0, 6, b"MOJO", b"MOJO BY MATT FURIES", x"416c6c206f66204d61747420467572696573206f7468657220776f726b207374656d732066726f6d2074686973206f6e65206c6974746c65206d6f6e6b65792e0a0a245045504520686173206265656e2077616c6b696e6720696e20244d4f4a4f7320666f6f74737465707320746869732077686f6c652074696d652e204974732074696d652074686520776f726c642072656d656d626572732077686f20746865206f726967696e616c206973", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cfk_AX_Geb_400x400_0244f86ff2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xc191311c5e5db3c46fa0b632e47c32423be3d052243119e09e1bc21c7a473a0c::sbbm {
    struct SBBM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBBM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBBM>(arg0, 6, b"SBBM", b"SAFE BABY MOON", b" Born to moon! . Join the baby brigade and lets ride to the top", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_19_43_14_7ffcadbae1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBBM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBBM>>(v1);
    }

    // decompiled from Move bytecode v6
}


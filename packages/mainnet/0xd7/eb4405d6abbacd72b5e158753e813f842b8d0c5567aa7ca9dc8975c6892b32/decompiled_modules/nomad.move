module 0xd7eb4405d6abbacd72b5e158753e813f842b8d0c5567aa7ca9dc8975c6892b32::nomad {
    struct NOMAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOMAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOMAD>(arg0, 6, b"NOMAD", b"NOMAD ON SUI", x"48492042524f5321210a4e4f4d4144204f4e20535549204e4f572121200a46524f4d205255475320544f205249434845532121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_nomad_189f4e769e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOMAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOMAD>>(v1);
    }

    // decompiled from Move bytecode v6
}


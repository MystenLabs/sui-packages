module 0xd671a94df2274a83a3a0d3d4f649d24ed47765c3874dbe7d4ee11bd992262637::heipua {
    struct HEIPUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEIPUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEIPUA>(arg0, 6, b"HEIPUA", b"Heihei and Pua", b"cheeky rooster, clumsy piglet ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0925_5a4b358dce.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEIPUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEIPUA>>(v1);
    }

    // decompiled from Move bytecode v6
}


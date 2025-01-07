module 0x110004068f243853c59871d64381796d3ffaf9aa0856d7f9fd0caf94eb52a87d::kla {
    struct KLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLA>(arg0, 6, b"KLA", b"KLAUS", b"kalus join", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8996_55ef65c5b9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KLA>>(v1);
    }

    // decompiled from Move bytecode v6
}


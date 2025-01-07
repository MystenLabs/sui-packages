module 0x82a1cabdc9852276135a87268f0a23afd842b6911375f00293e7db068182c49a::blubb {
    struct BLUBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBB>(arg0, 6, b"Blubb", b"Blubber", b"Bubble ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026390_f41844d894.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBB>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x303c67b646ae175e87b16265a22aedadfca62a186acdbb9c7d4090cf8dba7155::bone {
    struct BONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONE>(arg0, 6, b"BONE", b"BONE THE DOG", b"Bone is a memecoin that makes a difference in sui Blockchain with open source, bone will make the sui community hype", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3870_4c9cd7d8fc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONE>>(v1);
    }

    // decompiled from Move bytecode v6
}


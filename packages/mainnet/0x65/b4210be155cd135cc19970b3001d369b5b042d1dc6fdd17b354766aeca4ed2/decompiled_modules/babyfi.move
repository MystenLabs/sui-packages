module 0x65b4210be155cd135cc19970b3001d369b5b042d1dc6fdd17b354766aeca4ed2::babyfi {
    struct BABYFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYFI>(arg0, 6, b"Babyfi", b"Babyfication", b"infinite memeablity, and any future viral moments or videos will be able to be babified", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_05_09_110810_8d67de2244.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYFI>>(v1);
    }

    // decompiled from Move bytecode v6
}


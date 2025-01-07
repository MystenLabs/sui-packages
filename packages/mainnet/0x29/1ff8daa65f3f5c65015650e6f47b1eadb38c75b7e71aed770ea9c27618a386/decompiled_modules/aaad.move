module 0x291ff8daa65f3f5c65015650e6f47b1eadb38c75b7e71aed770ea9c27618a386::aaad {
    struct AAAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAD>(arg0, 6, b"AAAD", b"AAAAAAAA DOG", b"AAADOG is always barking \"AAAAA\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_06_18_22_54_removebg_preview_656832ab53.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAD>>(v1);
    }

    // decompiled from Move bytecode v6
}


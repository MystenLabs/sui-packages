module 0xfddeb4956e9bf7c3ab16e323081715fcd0dd999ca059a89a1c5c084b18358d1f::vlad {
    struct VLAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VLAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VLAD>(arg0, 6, b"VLAD", b"VLADIK", b"VLADIK - the most expensive and the beautiful man token in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732974920546.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VLAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VLAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


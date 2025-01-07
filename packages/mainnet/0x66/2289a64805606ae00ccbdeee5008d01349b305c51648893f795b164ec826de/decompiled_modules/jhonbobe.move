module 0x662289a64805606ae00ccbdeee5008d01349b305c51648893f795b164ec826de::jhonbobe {
    struct JHONBOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHONBOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JHONBOBE>(arg0, 6, b"JHONBOBE", b"Jhon BOBE recovery", x"616e642049207472756c792061706f6c6f67697a6520746f2074686f73652077686f2068617665206265656e206861726d65642c204920686f70652074686572652077696c6c206265206e6f206d6f7265206675636b6564207570206861636b6572732061726f756e642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037915_f3d0c4b028.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JHONBOBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JHONBOBE>>(v1);
    }

    // decompiled from Move bytecode v6
}


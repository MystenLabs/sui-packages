module 0xe6fdfad207f7eca7641ee5e0b0a63ae8642c5cd3f3db9d280c4385fd51a7e845::swana {
    struct SWANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWANA>(arg0, 6, b"sWANA", b"Suiwana", b"I am lit af $Suiwana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_03_T141131_378_ecaa7ebe27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWANA>>(v1);
    }

    // decompiled from Move bytecode v6
}


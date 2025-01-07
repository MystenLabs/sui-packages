module 0xefe75cf8024ba36cf69e208affc88cc122c929a87468c6cf8dd031c6c35eed31::surby {
    struct SURBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURBY>(arg0, 6, b"SURBY", b"SURBY THE SUI", b"The most memeable meme on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SURBY_PROFILE_7f43df1827_7aa7d514e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURBY>>(v1);
    }

    // decompiled from Move bytecode v6
}


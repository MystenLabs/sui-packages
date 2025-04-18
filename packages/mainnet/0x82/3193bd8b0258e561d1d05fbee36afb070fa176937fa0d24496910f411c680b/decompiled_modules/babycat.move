module 0x823193bd8b0258e561d1d05fbee36afb070fa176937fa0d24496910f411c680b::babycat {
    struct BABYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYCAT>(arg0, 6, b"BABYCAT", b"Baby Cay", b"babycat is a cute adorable cat that will be an iconic coin in the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000059594_1103cd8e3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


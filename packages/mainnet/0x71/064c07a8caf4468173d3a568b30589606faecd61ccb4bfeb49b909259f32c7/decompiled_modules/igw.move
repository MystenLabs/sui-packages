module 0x71064c07a8caf4468173d3a568b30589606faecd61ccb4bfeb49b909259f32c7::igw {
    struct IGW has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGW>(arg0, 6, b"IGW", b"Internet Generational Wealth", b"The Architects of $IGW, the dreamers of Internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047973_eaa8d9c577.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IGW>>(v1);
    }

    // decompiled from Move bytecode v6
}


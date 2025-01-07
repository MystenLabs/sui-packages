module 0x86a05104c442b3a25611c09fb9b66db10512cfb2aa3849d45c26e4b194480f0b::burny {
    struct BURNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURNY>(arg0, 6, b"BURNY", b"Burny", b"$burny. burning money to make money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gif_ezgif_com_optimize_232544a112.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURNY>>(v1);
    }

    // decompiled from Move bytecode v6
}


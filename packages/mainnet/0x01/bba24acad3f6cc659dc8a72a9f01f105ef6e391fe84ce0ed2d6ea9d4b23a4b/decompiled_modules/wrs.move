module 0x1bba24acad3f6cc659dc8a72a9f01f105ef6e391fe84ce0ed2d6ea9d4b23a4b::wrs {
    struct WRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRS>(arg0, 6, b"WRS", b"Walrus", b"Walrus will become the most representative MEME on the SUI chain and will gain the attention of SUI officials", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_e_7e9e094a5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WRS>>(v1);
    }

    // decompiled from Move bytecode v6
}


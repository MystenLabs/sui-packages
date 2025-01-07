module 0xf2f0adf66f236dfde27ed3cb9b2c1c39e7fbe42b8226458791b0a0f9e9772275::suich {
    struct SUICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICH>(arg0, 6, b"Suich", b"Swiss cheese sui", b"Swiss Cheese Sui is the refined connoisseur of the cheese world, bringing a rich, nutty flavor that elevates any gourmet experience to new heights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3456zdxsgvfadsg_7979083749.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICH>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xcd9d9c3087b5a3a3d1cc79e82b02f8d1d9b6c758e03e31c7b2779fa5b5f00913::greninja {
    struct GRENINJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRENINJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRENINJA>(arg0, 6, b"Greninja", x"506f6bc3a96d6f6e205761732042414e4e4544", x"5468697320506f6bc3a96d6f6e205761732042414e4e454420696e207468652047616d6573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigeyaajxx6dujuqec6zz5ummfyhl2fljy652vgpndpxqviwvovi3a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRENINJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GRENINJA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


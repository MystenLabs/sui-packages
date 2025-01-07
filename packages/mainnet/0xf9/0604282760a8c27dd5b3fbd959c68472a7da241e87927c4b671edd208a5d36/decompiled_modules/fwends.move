module 0xf90604282760a8c27dd5b3fbd959c68472a7da241e87927c4b671edd208a5d36::fwends {
    struct FWENDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWENDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWENDS>(arg0, 6, b"FWENDS", b"MEME FWENDS", b"A memecoin that is run by the community, our Fwends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/412f7754_c186_4eaf_862d_b43580423730_e9c18cbdb8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWENDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWENDS>>(v1);
    }

    // decompiled from Move bytecode v6
}


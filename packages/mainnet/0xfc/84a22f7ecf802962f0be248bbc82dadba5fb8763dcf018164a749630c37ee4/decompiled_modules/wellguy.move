module 0xfc84a22f7ecf802962f0be248bbc82dadba5fb8763dcf018164a749630c37ee4::wellguy {
    struct WELLGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WELLGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WELLGUY>(arg0, 6, b"WELLGUY", b"Well..Guy", b"The Chillest Penguin on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WELLGUY_ICON_d536f70c3a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WELLGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WELLGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}


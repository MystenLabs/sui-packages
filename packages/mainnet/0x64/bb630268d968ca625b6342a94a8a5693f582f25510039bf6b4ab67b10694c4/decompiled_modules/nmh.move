module 0x64bb630268d968ca625b6342a94a8a5693f582f25510039bf6b4ab67b10694c4::nmh {
    struct NMH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NMH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NMH>(arg0, 6, b"NMH", b"No More Hashtags", x"4e4f204d4f5245204841534854414753210a4e4f204d4f524520484153485441475321210a4e4f204d4f52452048415348544147532121210a0a4e4d4821212120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3081_87403fe7f9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NMH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NMH>>(v1);
    }

    // decompiled from Move bytecode v6
}


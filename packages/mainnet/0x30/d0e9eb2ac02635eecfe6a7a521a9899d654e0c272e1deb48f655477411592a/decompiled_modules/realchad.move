module 0x30d0e9eb2ac02635eecfe6a7a521a9899d654e0c272e1deb48f655477411592a::realchad {
    struct REALCHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALCHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALCHAD>(arg0, 6, b"REALCHAD", b"real chad on sui(CHAD)", b"a very handsome,strong and very smart chad,a friend of SUIJAK.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/26cd5649566662da219669b02463897_89088a2622.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALCHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REALCHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}


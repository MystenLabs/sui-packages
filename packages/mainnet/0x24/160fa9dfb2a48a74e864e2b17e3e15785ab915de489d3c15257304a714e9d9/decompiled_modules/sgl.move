module 0x24160fa9dfb2a48a74e864e2b17e3e15785ab915de489d3c15257304a714e9d9::sgl {
    struct SGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGL>(arg0, 6, b"SGL", b"SuiGallerie", x"41207265766f6c7574696f6e6172792057656233207175657374696e6720706c6174666f726d206f6e200a405375694e6574776f726b20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uf_Y_Vmow_U_400x400_753a846292.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGL>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x36a11a80436e7947aa00b817587459a6ce45e452510f0f2bdaf3b498495b2fd::come {
    struct COME has drop {
        dummy_field: bool,
    }

    fun init(arg0: COME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COME>(arg0, 6, b"COME", b"Call of Memes", x"2331204d656d6520436f696e206f6620235355492c20612070696f6e656572696e6720696e69746961746976652073657420746f207472616e73666f726d2074686520776562332065636f73797374656d20627920626c656e64696e672074686520706c617966756c20737069726974206f66206d656d6573207769746820746865206c7578757279206f6620796163687420636c75622063756c747572652e200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wk_OHZR_7_Z_400x400_07ac46cae4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COME>>(v1);
    }

    // decompiled from Move bytecode v6
}


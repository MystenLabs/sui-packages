module 0xf098cf5c7537a1c628ee270be2eb0f220f5468ad66773a52214b7af6723726ab::gbt {
    struct GBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBT>(arg0, 6, b"GBT", b"GABUT", x"47616275742c20697320726973696e67207374617220696e20746865206d656d652067616d6520756e697665727365206f6e207468652053554920626c6f636b636861696e2e204761627574206272696e6773206120706c617966756c207477697374207769746820697473206c616d612d7468656d656420636861726d2e20456d627261636520746865207768696d736963616c20776f726c640a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gemini_Generated_Image_kpvk3bkpvk3bkpvk_42528b88f9_aa2de9a143.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBT>>(v1);
    }

    // decompiled from Move bytecode v6
}


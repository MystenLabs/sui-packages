module 0x694e0bee468b1dc531f1f421847b0022f2210897448f7435d4eff1899586db7b::purr {
    struct PURR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURR>(arg0, 6, b"PURR", b"Purrl Cat", x"546865206f6e6c79206b6e6f776e2070686f746f20746f206d616e6b696e64206f66207468697320756e646572776174657220636174207370656369652e204e6576657220746f206265207365656e20616761696e2073696e63652031302f30342f30312e204e6f77206c69766573206f6e207468652053756920626c6f636b636861696e20666f72657665722e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ocean_cat_e4d22ae022.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURR>>(v1);
    }

    // decompiled from Move bytecode v6
}


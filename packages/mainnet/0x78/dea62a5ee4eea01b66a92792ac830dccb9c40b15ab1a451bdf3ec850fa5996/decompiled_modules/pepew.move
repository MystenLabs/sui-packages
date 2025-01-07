module 0x78dea62a5ee4eea01b66a92792ac830dccb9c40b15ab1a451bdf3ec850fa5996::pepew {
    struct PEPEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEW>(arg0, 6, b"PEPEW", b"PEPEW SUI", x"5045504557202068697420726f636b20626f74746f6d686f6d656c6573732c2064696767696e67207468726f7567682074726173682c20616e6420736d656c6c696e67206c696b6520726f61646b696c6c2e2052656a65637465642062792050656e656c6f706520616e642074686520776f726c642c2065766572796f6e652074686f7567687420686520776173206a7573742061207761736865642d757020736b756e6b2077697468207a65726f2073686f7420617420737563636573732e20427574207468656e2c20736f6d657468696e67207374616e6b792068617070656e65642e2e2e206f70706f7274756e697479206b6e6f636b65642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_icon_192x192_cc5bacc2ed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEW>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x50edf61e034df0de61c98cbe7e7a1f087a4a4278eb44dbcc618f38fd3cde628d::beb {
    struct BEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEB>(arg0, 9, b"BEB", b"bebe", x"616e6f74686572206f6e652061626f75742062656265636f696e0a4e75727475726520796f757220696e766573746d656e747320776974682042656265436f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11a349b1-c873-46aa-859c-648c9d4b3544.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEB>>(v1);
    }

    // decompiled from Move bytecode v6
}


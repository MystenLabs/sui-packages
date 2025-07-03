module 0x1e055c8892b3c3df0dd8d47273bcbf4aa25952f3a83a223f71b48aba93fe29db::undead {
    struct UNDEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNDEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNDEAD>(arg0, 9, b"UNDEAD", b"undead", b"{\"description\":\"he's description. \",\"twitter\":\"https://twitter.com/undead\",\"website\":\"\",\"telegram\":\"\",\"tags\":[\"dead\",\"undead\"]}", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/923e617c-8203-477a-aecc-cba9da42fbb5.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNDEAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNDEAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


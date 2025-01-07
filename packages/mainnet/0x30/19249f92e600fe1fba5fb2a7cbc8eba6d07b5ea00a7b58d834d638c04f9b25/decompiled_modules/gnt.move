module 0x3019249f92e600fe1fba5fb2a7cbc8eba6d07b5ea00a7b58d834d638c04f9b25::gnt {
    struct GNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNT>(arg0, 9, b"GNT", b"GOOD NEWS ", b"Good News Token is created to promote Good Content across social platforms, a Good news will Unit the world, promote Good News", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb4e7b97-5de2-4587-984c-138984ef9bde.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GNT>>(v1);
    }

    // decompiled from Move bytecode v6
}


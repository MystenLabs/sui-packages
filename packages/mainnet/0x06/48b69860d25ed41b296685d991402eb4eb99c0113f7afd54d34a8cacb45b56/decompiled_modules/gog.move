module 0x648b69860d25ed41b296685d991402eb4eb99c0113f7afd54d34a8cacb45b56::gog {
    struct GOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOG>(arg0, 9, b"GOG", b"dogbum", b"LAUGHING STONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67225951-8099-4e36-a550-91a11077fabf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOG>>(v1);
    }

    // decompiled from Move bytecode v6
}


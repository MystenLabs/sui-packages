module 0x2cad70725ba7fc54b59157823cbf726369a349f983aa1840b97818bddc345e4d::gun {
    struct GUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUN>(arg0, 6, b"GUN", b"Gunbot", b"This token powers an advanced crypto sniper tool designed for rapid token trading. Gain a competitive edge with real-time alerts, auto-sniping features, and precise execution, ensuring you never miss profitable opportunities in decentralized mark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734761975816.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


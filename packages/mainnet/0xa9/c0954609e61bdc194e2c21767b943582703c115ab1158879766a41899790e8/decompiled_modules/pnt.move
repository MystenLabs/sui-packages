module 0xa9c0954609e61bdc194e2c21767b943582703c115ab1158879766a41899790e8::pnt {
    struct PNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNT>(arg0, 9, b"PNT", b"PHANTOM", b"PHANTOM is a cutting-edge blockchain token designed for ultra-fast transactions and low fees. It powers the Phantom ecosystem, enabling seamless interaction with decentralized applications and enhancing user experience in the world of digital assets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/848eae5b-cce7-4047-8f48-8f25ae53afc4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNT>>(v1);
    }

    // decompiled from Move bytecode v6
}


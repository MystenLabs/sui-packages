module 0xe7de272d0b1e417a7a40c46006b75fe9ae7d6e67d9f64cd89c8dca7b5edc827f::PENGTRENCH {
    struct PENGTRENCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGTRENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGTRENCH>(arg0, 6, b"TrenchPeng", b"PENGTRENCH", b"A meme coin celebrating the brave animated penguin holding the line in the trenches. PENGTRENCH is all about resilience, camaraderie, and the unstoppable spirit of the underdog. Join the waddle and hodl the line!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreif32ekulyv2xmrn6hnfbuu6sq5o3nto7a7ax7zvyzsufkde2ufsqm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGTRENCH>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGTRENCH>>(v1);
    }

    // decompiled from Move bytecode v6
}


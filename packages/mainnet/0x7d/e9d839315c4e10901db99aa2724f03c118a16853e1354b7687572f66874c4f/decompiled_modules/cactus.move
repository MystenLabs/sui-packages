module 0x7de9d839315c4e10901db99aa2724f03c118a16853e1354b7687572f66874c4f::cactus {
    struct CACTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CACTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CACTUS>(arg0, 6, b"CACTUS", b"SUI-YOTE", b"Enlightenment is imminent within the walls of this community. Join us in the desert, where all we need is a drop of water......", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749968104560.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CACTUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CACTUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


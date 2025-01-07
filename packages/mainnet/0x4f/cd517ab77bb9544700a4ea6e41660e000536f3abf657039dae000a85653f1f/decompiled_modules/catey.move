module 0x4fcd517ab77bb9544700a4ea6e41660e000536f3abf657039dae000a85653f1f::catey {
    struct CATEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATEY>(arg0, 6, b"CATEY", b"Catey", b"Catey is a free-spirited cat, always one step ahead. Each time he appears, the Sui community scrambles to follow his trail, hoping to decode his moves and seize profit opportunities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727241651988_964cb3e3b77d1e7515aa6e49e88b0ffd_475821c440.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATEY>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x899762766feea93bdf2509f364a1beedfcf2ea0ae9bdd38b98843fa268613a1f::bonksui {
    struct BONKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKSUI>(arg0, 6, b"BONKSUI", b"Bonk On Sui", b"Lets enjoy your BONK with SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5848_504642fcbd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


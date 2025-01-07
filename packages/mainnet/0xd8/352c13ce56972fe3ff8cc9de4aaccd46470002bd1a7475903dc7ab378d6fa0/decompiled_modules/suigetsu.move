module 0xd8352c13ce56972fe3ff8cc9de4aaccd46470002bd1a7475903dc7ab378d6fa0::suigetsu {
    struct SUIGETSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGETSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGETSU>(arg0, 6, b"Suigetsu", b"Suigetsu Hozuki", b"The annoying but wavy side character ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1823_8324038427.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGETSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGETSU>>(v1);
    }

    // decompiled from Move bytecode v6
}


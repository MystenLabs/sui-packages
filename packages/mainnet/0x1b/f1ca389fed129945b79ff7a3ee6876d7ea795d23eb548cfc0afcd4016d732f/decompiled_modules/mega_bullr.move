module 0x1bf1ca389fed129945b79ff7a3ee6876d7ea795d23eb548cfc0afcd4016d732f::mega_bullr {
    struct MEGA_BULLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGA_BULLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGA_BULLR>(arg0, 9, b"MEGA_BULLR", b"Megabullr", b"In preparation for bull run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/497e621f-3f8d-4353-871a-0a3174feea28.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGA_BULLR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEGA_BULLR>>(v1);
    }

    // decompiled from Move bytecode v6
}


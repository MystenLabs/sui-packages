module 0xf3489e3f8643b3fb41ed183d2794aa521424934fa9fffdd4fff4b97d04ddf02b::wii {
    struct WII has drop {
        dummy_field: bool,
    }

    fun init(arg0: WII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WII>(arg0, 6, b"Wii", b"Wilson", b"Lost but not forgotten, Wilson finds a new home on the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734931695923.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WII>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WII>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


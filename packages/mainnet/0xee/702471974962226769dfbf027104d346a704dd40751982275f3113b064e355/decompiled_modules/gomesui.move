module 0xee702471974962226769dfbf027104d346a704dd40751982275f3113b064e355::gomesui {
    struct GOMESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOMESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOMESUI>(arg0, 6, b"GOMESUI", b"GAMEOFMEMES", b"Horde Survival where you play as Memes with Guns ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r_Hr_EYP_57_400x400_71fdf4769d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOMESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOMESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


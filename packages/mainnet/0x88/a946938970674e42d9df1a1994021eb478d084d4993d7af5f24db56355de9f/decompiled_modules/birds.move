module 0x88a946938970674e42d9df1a1994021eb478d084d4993d7af5f24db56355de9f::birds {
    struct BIRDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDS>(arg0, 6, b"BIRDS", b"SUI BIRDS", b"$BIRDS - The Memecoin and GameFi, inspired by Telegram & X ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gio_IU_Wqx_400x400_816aacb2d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDS>>(v1);
    }

    // decompiled from Move bytecode v6
}


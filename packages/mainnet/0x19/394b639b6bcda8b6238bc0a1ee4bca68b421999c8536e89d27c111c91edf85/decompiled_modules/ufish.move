module 0x19394b639b6bcda8b6238bc0a1ee4bca68b421999c8536e89d27c111c91edf85::ufish {
    struct UFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFISH>(arg0, 6, b"UFISH", b"UniFish", b"@UniFishSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G4rgb_Sa_W_400x400_1b5ebc4ef5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}


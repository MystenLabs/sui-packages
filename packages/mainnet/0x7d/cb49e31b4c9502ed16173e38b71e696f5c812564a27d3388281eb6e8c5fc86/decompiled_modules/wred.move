module 0x7dcb49e31b4c9502ed16173e38b71e696f5c812564a27d3388281eb6e8c5fc86::wred {
    struct WRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRED>(arg0, 9, b"WRED", b"red wall", b"red walli", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0dfd821cd022088c2d5c967b9d472d56blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WRED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


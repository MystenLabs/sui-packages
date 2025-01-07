module 0xf0135165b3974e31556f29f523464bb4ecc51e9b60d895eb3bccf13720b0b7a5::tom369 {
    struct TOM369 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOM369, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOM369>(arg0, 9, b"TOM369", b"Tom&Jerry", b"Making funny social network and memory about your childhood", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/858a3d0c-ba67-4202-bbff-11ee5a9587ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOM369>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOM369>>(v1);
    }

    // decompiled from Move bytecode v6
}


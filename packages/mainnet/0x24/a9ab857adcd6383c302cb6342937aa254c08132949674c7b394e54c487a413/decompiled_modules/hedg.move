module 0x24a9ab857adcd6383c302cb6342937aa254c08132949674c7b394e54c487a413::hedg {
    struct HEDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEDG>(arg0, 9, b"HEDG", b"hedgehog", b"a cute hedgehog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53f32669-f34d-4eb4-b04c-be8bca81dd05.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEDG>>(v1);
    }

    // decompiled from Move bytecode v6
}


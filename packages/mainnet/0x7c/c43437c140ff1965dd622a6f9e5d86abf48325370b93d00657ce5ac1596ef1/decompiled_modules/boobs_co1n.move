module 0x7cc43437c140ff1965dd622a6f9e5d86abf48325370b93d00657ce5ac1596ef1::boobs_co1n {
    struct BOOBS_CO1N has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBS_CO1N, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBS_CO1N>(arg0, 9, b"BOOBS_CO1N", b"BOOBS", b"boobs is love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5935586d-21cd-49f4-af71-125ed362dffc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBS_CO1N>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOBS_CO1N>>(v1);
    }

    // decompiled from Move bytecode v6
}


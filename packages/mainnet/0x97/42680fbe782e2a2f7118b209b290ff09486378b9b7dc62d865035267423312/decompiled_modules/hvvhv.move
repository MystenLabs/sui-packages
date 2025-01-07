module 0x9742680fbe782e2a2f7118b209b290ff09486378b9b7dc62d865035267423312::hvvhv {
    struct HVVHV has drop {
        dummy_field: bool,
    }

    fun init(arg0: HVVHV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HVVHV>(arg0, 9, b"HVVHV", b"Vyvy", b"Tctftft", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02c263ba-afc2-4e4c-9974-918ae65267ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HVVHV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HVVHV>>(v1);
    }

    // decompiled from Move bytecode v6
}


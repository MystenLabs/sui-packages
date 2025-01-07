module 0x239283ac330d58aac2756a9ce8feb394c0c52f15a8e2131179aabee859500513::cutedog {
    struct CUTEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTEDOG>(arg0, 9, b"CUTEDOG", b"CUTE DOG", b"JUST A CUTE DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/13ce3eef-6fe0-4db2-9716-707ca48487ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUTEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}


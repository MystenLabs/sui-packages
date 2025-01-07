module 0x79c905d1f30b7245b6c453915db6c272172e252ba27f33f9a802bcde6a21bf18::bibkatlr {
    struct BIBKATLR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBKATLR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBKATLR>(arg0, 9, b"BIBKATLR", b"Bibka", b"Bibka can bio bip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce64e692-d9db-425a-bc68-2302890336bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBKATLR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIBKATLR>>(v1);
    }

    // decompiled from Move bytecode v6
}


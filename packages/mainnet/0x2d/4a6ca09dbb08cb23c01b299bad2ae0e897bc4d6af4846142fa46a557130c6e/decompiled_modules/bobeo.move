module 0x2d4a6ca09dbb08cb23c01b299bad2ae0e897bc4d6af4846142fa46a557130c6e::bobeo {
    struct BOBEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBEO>(arg0, 9, b"BOBEO", b"BUTOC", b"THIS IS BUTOC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/079dc5ba-dd1f-47af-a0dd-410e96661837.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBEO>>(v1);
    }

    // decompiled from Move bytecode v6
}


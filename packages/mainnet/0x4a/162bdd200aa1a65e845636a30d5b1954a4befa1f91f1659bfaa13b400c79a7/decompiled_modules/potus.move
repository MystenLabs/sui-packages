module 0x4a162bdd200aa1a65e845636a30d5b1954a4befa1f91f1659bfaa13b400c79a7::potus {
    struct POTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTUS>(arg0, 9, b"POTUS", b"Camela", b"MAGA MUSK HEDGE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0004d21f-2b0c-435b-a1ff-0f9cc7ffc056.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}


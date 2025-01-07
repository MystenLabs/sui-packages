module 0x8e0643b3a2541429d5b04539cfc75201977e5dd09852049bc90f72a8bf42d58c::mh23069 {
    struct MH23069 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MH23069, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MH23069>(arg0, 9, b"MH23069", b"ChipMunk", b"inspiration from funny squirrels", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50226efd-5507-4412-88e6-da252565353c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MH23069>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MH23069>>(v1);
    }

    // decompiled from Move bytecode v6
}


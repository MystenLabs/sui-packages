module 0x83bedbe9be247023e1d2c7ba9e0832e7770a021c8ced3eb503101c06668ea2df::mh23069 {
    struct MH23069 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MH23069, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MH23069>(arg0, 9, b"MH23069", b"ChipMunk", b"inspiration from funny squirrels", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53525990-ed05-4502-83d7-5e7d2840ee35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MH23069>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MH23069>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x19b6c0723ac54944555de05249b0698a97f66359fe4643325a5fb1cd391dd24a::dndm {
    struct DNDM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNDM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNDM>(arg0, 9, b"DNDM", b"Jssjns", b"Sjsndnnfn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/947d875e-8f4e-4efc-8d94-2e1ff1deaae8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNDM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNDM>>(v1);
    }

    // decompiled from Move bytecode v6
}


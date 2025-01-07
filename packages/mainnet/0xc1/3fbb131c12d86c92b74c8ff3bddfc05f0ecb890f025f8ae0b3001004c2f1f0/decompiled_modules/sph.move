module 0xc13fbb131c12d86c92b74c8ff3bddfc05f0ecb890f025f8ae0b3001004c2f1f0::sph {
    struct SPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPH>(arg0, 9, b"SPH", b"Sphere", b"Sphere is a sustainable cryptocurrency designed to promote environmental initiatives and carbon offset projects. By incentivizing eco-friendly practices, it empowers users to contribute to a greener planet while enjoying a secure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4a92ef9a-d762-4920-b6d6-4d34a60083ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPH>>(v1);
    }

    // decompiled from Move bytecode v6
}


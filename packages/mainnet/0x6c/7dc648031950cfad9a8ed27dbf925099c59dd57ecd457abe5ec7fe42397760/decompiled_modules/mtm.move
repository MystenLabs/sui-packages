module 0x6c7dc648031950cfad9a8ed27dbf925099c59dd57ecd457abe5ec7fe42397760::mtm {
    struct MTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTM>(arg0, 9, b"MTM", b"Volkswagen", b"boasting distinctive branding and dynamic community engagement to build excitement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3213f880-dc70-4664-8e5b-7c956374e9b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTM>>(v1);
    }

    // decompiled from Move bytecode v6
}


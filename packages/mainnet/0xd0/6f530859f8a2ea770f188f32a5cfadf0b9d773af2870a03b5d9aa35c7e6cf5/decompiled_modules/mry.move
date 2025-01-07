module 0xd06f530859f8a2ea770f188f32a5cfadf0b9d773af2870a03b5d9aa35c7e6cf5::mry {
    struct MRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRY>(arg0, 9, b"MRY", b"miroh ya", b"bibik", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5058e0fb-4016-4b8d-9c96-0782d183325e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRY>>(v1);
    }

    // decompiled from Move bytecode v6
}


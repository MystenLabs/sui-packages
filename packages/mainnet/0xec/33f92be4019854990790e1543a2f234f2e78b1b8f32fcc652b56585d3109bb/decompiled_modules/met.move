module 0xec33f92be4019854990790e1543a2f234f2e78b1b8f32fcc652b56585d3109bb::met {
    struct MET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MET>(arg0, 9, b"MET", b"Metw", b"Metwave ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2912734-44c6-47b1-9204-28423b639ec0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MET>>(v1);
    }

    // decompiled from Move bytecode v6
}


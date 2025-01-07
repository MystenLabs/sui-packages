module 0x625e056a4c21fff7530616fe5ba7807f7708410de4ffbf08c84f5557037aef16::ffh {
    struct FFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFH>(arg0, 9, b"FFH", b"GIU", b"Get Get Get ASAP ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62b62766-9943-43bf-b668-a55b0831ab95.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFH>>(v1);
    }

    // decompiled from Move bytecode v6
}


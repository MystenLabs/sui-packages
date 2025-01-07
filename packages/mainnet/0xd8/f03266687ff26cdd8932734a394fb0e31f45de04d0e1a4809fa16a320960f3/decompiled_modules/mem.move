module 0xd8f03266687ff26cdd8932734a394fb0e31f45de04d0e1a4809fa16a320960f3::mem {
    struct MEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEM>(arg0, 9, b"MEM", b"CHENGPUMP", b"We all believe in the sui ecosystem and its creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8664e78-d245-47ff-a12d-368fafa4e245.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEM>>(v1);
    }

    // decompiled from Move bytecode v6
}


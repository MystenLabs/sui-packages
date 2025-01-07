module 0x51028c3c01e97ff749bd8806e670647d163d64e144c39298631681af14f9daf2::soggy {
    struct SOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOGGY>(arg0, 6, b"Soggy", b"SoggySui", b"Drenched in memes, overflowing with gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_075105798_d028fd1011.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}


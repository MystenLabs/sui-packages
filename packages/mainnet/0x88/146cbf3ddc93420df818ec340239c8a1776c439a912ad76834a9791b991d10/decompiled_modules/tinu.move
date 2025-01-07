module 0x88146cbf3ddc93420df818ec340239c8a1776c439a912ad76834a9791b991d10::tinu {
    struct TINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINU>(arg0, 6, b"TINU", b"Tana Inu", b"COMBINE A CHIER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ZOOMED_de15d7dba3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINU>>(v1);
    }

    // decompiled from Move bytecode v6
}


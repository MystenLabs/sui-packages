module 0x84c7af2eed602a9907a12498e65074def762f611d06c14ec12faa20942f387aa::motosui {
    struct MOTOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTOSUI>(arg0, 6, b"MOTOSUI", b"motorSUIcle", b"JUST RIDE !!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/efnyezap_7d68155256.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOTOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


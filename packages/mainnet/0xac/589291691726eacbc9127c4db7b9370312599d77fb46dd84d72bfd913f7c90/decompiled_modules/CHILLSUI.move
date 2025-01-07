module 0xac589291691726eacbc9127c4db7b9370312599d77fb46dd84d72bfd913f7c90::CHILLSUI {
    struct CHILLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLSUI>(arg0, 9, b"CHILLSUI", b"CHILLSUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLSUI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILLSUI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHILLSUI>>(0x2::coin::mint<CHILLSUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


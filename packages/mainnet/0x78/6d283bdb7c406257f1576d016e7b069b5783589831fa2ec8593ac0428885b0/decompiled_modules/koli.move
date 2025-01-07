module 0x786d283bdb7c406257f1576d016e7b069b5783589831fa2ec8593ac0428885b0::koli {
    struct KOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLI>(arg0, 9, b"KOLI", b"Kokokoli", b"Kokokoli is a type of warrior rooster...it's a fighter...wins battle...never give up....always focus on enemies weakness...very sharp...very intelligent..brave Rooster...it is found in south east asiy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4de539d1-a745-407f-abf8-8533bb351316.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOLI>>(v1);
    }

    // decompiled from Move bytecode v6
}


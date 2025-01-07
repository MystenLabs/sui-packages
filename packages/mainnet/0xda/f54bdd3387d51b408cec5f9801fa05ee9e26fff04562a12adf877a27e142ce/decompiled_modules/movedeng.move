module 0xdaf54bdd3387d51b408cec5f9801fa05ee9e26fff04562a12adf877a27e142ce::movedeng {
    struct MOVEDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEDENG>(arg0, 6, b"MOVEDENG", b"Move Deng", x"4a757374206120766972616c206c696c2720686970706f20726964696e672074686520706f776572206f66204d6f76652050756d700a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_b09e47a9a6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}


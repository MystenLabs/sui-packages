module 0x417459f7b5d07375187975842062d010769d099ec55c18d570c16cb803a13fa0::lking {
    struct LKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: LKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LKING>(arg0, 9, b"LKING", b"Lion King", x"4c4b494e4720697320746f74616c6c7920636f6d6d756e6974792064726976656e20746f6b656e2e2049742077696c6c20626520612070757265206769667420746f206d7920636f6d6d756e6974792e20496620776520616c6c20686f6c642077652077696c6c20626520696e20687567652070726f6669742e20486f6c6420697320676f6c6420f09f92aa2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02d60e94-109b-4ee1-a94d-c7667c7e2770.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

